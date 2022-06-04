class UserMailer < ApplicationMailer
    
    def welcome_email(user)
        @user = user
        @url = 'http://example.com/login'
        mail(to: 'sergioeduardo2000@gmail.com', subject: "Welcome to team")
    end

end
