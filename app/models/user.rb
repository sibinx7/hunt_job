class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :email
  has_many :projects
  has_and_belongs_to_many :skills
  has_many :bids
  has_many :bank_accounts
  has_many :payments
  has_one :user_project_detail
  has_many :user_ratings
  has_many :admin_notifications
  # has_many :transactions
  has_attached_file :profile_image
  validates_attachment_content_type :profile_image, :content_type => /\Aimage\/.*\Z/
end
