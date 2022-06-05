class HomeController < ApplicationController
    layout 'home'
    
    def index
        if user_signed_in?
            @home_message = "Nice to see you again, #{current_user.full_name}!"
            if current_user.has_role? :admin
                @status = " admin!"
            else
                @status = " member"
            end
        else
            @status = "not_signed_in"
            @home_message = "What are you waiting to sign in?"
        end
    end
end