class TeamsController < ApplicationController
    before_action :authenticate_user!, except: [:index]
    def index 
        @teams = Team.all
    end

    def send_notification
        @team = Team.find(send_notification_params)
        
    end


    private 

    def send_notification_params
        params.require(:team).permit(:team_id)
    end
end
