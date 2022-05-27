class TeamsController < ApplicationController
    before_action :authenticate_user!, except: [:index]
    def index 
        @teams = Team.all
    end
end
