class Skill < ActiveRecord::Base
  has_and_belongs_to_many :projects
  attr_reader :id,:title,:description
end