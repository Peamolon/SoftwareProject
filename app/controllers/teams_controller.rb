class TeamsController < ApplicationController
    before_action :authenticate_user!, except: [:index]
    def index 
        @teams = Team.all
    end

    def show  
        @team = Team.find(params[:id])
        @members = @team.members
    end

    def new
        @team = Team.new
    end

    def create
        @team = Team.new(team_params)
        @user = current_user
        puts "El current user es #{@user.email}"
        @create_team_service = ::CreateTeamService.new(@team, @user);
        if @create_team_service.perfom
            redirect_to team_path(@team)
            flash[:notice] = "Team created"
        else
            flash[:error] = "Team not created"
            redirect_back(fallback_location: new_team_path)
        end
    end

    def destroy
        @team_invitations = TeamInvitation.where(team_id: params[:id])
        @team = Team.find(params[:id])
        @team_invitations.destroy_all
        @captain = @team.captain
        if @team.destroy
            @captain.roles.where(name: "captain").destroy_all
            flash[:notice] = "Team deleted"
            redirect_to root_path
        else
            flash[:error] = "Team not deleted"
            redirect_back(fallback_location: admin_index_path)
        end
    end


    def send_notification
        @team = Team.find(send_notification_params)     
    end

    def join_with_password
        @team = Team.find(params[:team_id])
        @user = current_user
        @member = @user.member
        @token = params[:password]
        if @token == @team.token
            @member.update(team_id: @team.id)
            flash[:notice] = "Team joined"
            redirect_to team_path(@team)
        else
            flash[:error] = "Wrong password"
            redirect_back(fallback_location: team_path(@team))
        end
    end

    def remove_member
        @member = Member.find(params[:member_to_remove_id])
        @team = @member.team
        @member.update(team_id: nil)
        if @member.user.has_role? :captain
            @member.user.roles.find_by(name: 'captain').destroy!
            @team.set_new_captain! if @team.members.count > 0
        end
        if @team.members.count == 0
            @team.team_invitations.destroy_all
            @team.destroy
        end
        UserMailer.notificate_remove_member(@member.user, @team).deliver_now
        redirect_to root_path
    end

    private 
    def team_params
        params.require(:team).permit(:name, :description)
    end

    def send_notification_params
        params.require(:team).permit(:team_id, :member_id)
    end
end
