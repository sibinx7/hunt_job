class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :email
  has_and_belongs_to_many :projects
  belongs_to :project
  has_attached_file :profile_image
  validates_attachment_content_type :profile_image, :content_type => /\Aimage\/.*\Z/
end
