class Bid < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  has_many :milestones

  # Validation
  validate :details , presence: true
  validate :duration, presence:true
  validate :bid , presence:true
end