class Comment < ActiveRecord::Base
  belongs_to :notice
  belongs_to :user
end
