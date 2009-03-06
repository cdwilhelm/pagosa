class Release < ActiveRecord::Base
  has_many :notice
  belongs_to :project
end
