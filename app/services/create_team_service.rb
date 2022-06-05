class CreateTeamService
  include ActiveModel::Model
  attr_accessor :user,
                :team
  validates :user, presence: true
  validates :team, presence: true
  def initialize(team, user)
    @user = user
    @team = team
    @member = @user.member
  end

  def perfom
    if self.valid?
      @team.save!
      set_captain!
      send_welcome_email!
      true
    else
      false
    end
  end

  def set_captain!
    @member.update(team_id: @team.id)
    @user.add_role :captain
  end

  def send_welcome_email!
    UserMailer.welcome_email(@user, @team).deliver_now
  end


end