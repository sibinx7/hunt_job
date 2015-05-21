class UserRating < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  validates_presence_of :user_id
  validates_presence_of :project_id
  validates_presence_of :description
  validates_presence_of :rating
  validates_presence_of :rated_by
end
