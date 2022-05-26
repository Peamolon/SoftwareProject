class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true
  validates :id_number, presence: true
  has_one :member, class_name: 'Member', foreign_key: 'user_id'
  has_one :admin, class_name: 'Admin', foreign_key: 'user_id'
end
