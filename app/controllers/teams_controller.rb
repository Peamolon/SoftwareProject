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
        if @team.save
            current_user.member.update(team_id: @team.id)
            current_user.add_role :captain
            redirect_to team_path(@team)
            flash[:notice] = "Team created"
        else
            flash[:error] = "Team not created"
            redirect_back(fallback_location: new_team_path)
        end
    end


    def send_notification
        @team = Team.find(send_notification_params)     
    end

    def remove_member
        @member = Member.find(params[:member_to_remove_id])
        @team = @member.team
        if @member.user.has_role? :captain
            @member.user.roles.find_by(name: 'captain').destroy!
            @team.set_new_captain!
        end
        @member.update(team_id: nil)
        redirect_to root_path
    end

    private 
    def team_params
        params.require(:team).permit(:name)
    end

    def send_notification_params
        params.require(:team).permit(:team_id, :member_id)
    end
end
