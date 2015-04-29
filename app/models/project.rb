class Project < ActiveRecord::Base
  validates_presence_of  :title
  validates_presence_of  :description
  validates_presence_of  :min_budget
  validates_presence_of  :max_budget
  validates_presence_of  :close_date

  has_and_belongs_to_many :skills ,:uniq => true
  has_one :user
  attr_reader :skill
  has_many :bids


  def skill=(id)
    self.skill = id.split(',')
  end
end
