class UserMailer < ApplicationMailer
    
    def welcome_email(user, team)
        @user = user
        @team = team
        mail(to: @user.email, subject: "Welcome to team #{@team.name}")
    end

end
