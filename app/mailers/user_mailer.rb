class UserMailer < ApplicationMailer
    
    def welcome_email(user, team)
        @user = user
        @team = team
        mail(to: @user.email, subject: "Welcome to team #{@team.name}")
    end

    def notificate_remove_member(user, team)
        @user = user
        @team = team
        mail(to: @user.email, subject: "You have been removed from team #{@team.name}")
    end

end
