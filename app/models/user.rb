class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true
  validates :id_number, presence: true
  validates :last_name, presence: true
  has_one :member, class_name: 'Member', foreign_key: 'user_id'

  after_create :set_default_role

  def full_name
    return "#{name} #{last_name}"
  end

  private

  def set_default_role
    self.add_role(:member) if self.roles.blank?
    self.create_member(framework: self.framework) if self.member.blank?
  end
end
