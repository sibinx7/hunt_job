class Payment < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  belongs_to :bid
  belongs_to :milestone
end

