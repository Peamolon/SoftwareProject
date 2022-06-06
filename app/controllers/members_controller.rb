class MembersController < ApplicationController
  before_action :authenticate_user!
  def new
    @member = Member.new
  end

  def create
    @user = User.new(member_params)
    @user.password = current_user.member.team.token
    if @user.save!
      @user.member.update(team_id: current_user.member.team_id)
      UserMailer.welcome_email(@user,current_user.member.team).deliver_now
      flash[:notice] = "Member created successfully"
      redirect_to team_path(current_user.member.team)
    else
      flash[:error] = "Member not created"
      render :new
    end
  end

  private
  def member_params
    params.require(:member).permit(:name, :email, :last_name, :framework, :id_number)
  end
end
