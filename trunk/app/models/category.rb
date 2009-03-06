class Category < ActiveRecord::Base
    has_many :notice
    belongs_to :project
end
