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

  def self.to_csv
    attributes = %w[id name last_name id_number email created_at ]
    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |user|
        csv << attributes.map { |attr| user.send(attr) }
      end
    end
  end

  private

  def set_default_role
    self.add_role(:member) if self.roles.blank?
    self.create_member(framework: self.framework) if self.member.blank?
  end
end
