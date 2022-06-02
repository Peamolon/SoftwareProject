class TeamInvitationsController < ApplicationController
    before_action :authenticate_user!
    protect_from_forgery with: :null_session
    skip_before_action :verify_authenticity_token

    def index
        @current_team = current_user.member.team if current_user.member.present?
        @team_invitations = TeamInvitation.where(team_id: @current_team.id)
    end

    def new
        @team_invitation = TeamInvitation.new
    end

    def create
        @team_invitation = TeamInvitation.new(team_invitation_params)
        @team_invitation.invited_at = Date.today
        if @team_invitation.save!
            redirect_to root_path
            flash[:notice] = "Invitation sent"
        else
            flash[:error] = "Invitation not sent!"
            redirect_to teams_path
        end
    end

    private 
    def team_invitation_params
        params.require(:team_invitation).permit(:team_id, :member_id)
    end
end