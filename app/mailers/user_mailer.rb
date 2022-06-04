class UserMailer < ApplicationMailer
    
    def welcome_email
        @user = User.first
        @team = Team.first
        @url = 'http://example.com/login'
        mail(to: 'sergioeduardo2000@gmail.com', subject: "Welcome to team")
    end

end
