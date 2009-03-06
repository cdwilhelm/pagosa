class Project < ActiveRecord::Base

  has_many :notice
  has_many :categories
  has_many :releases

end
