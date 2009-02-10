class User < ActiveRecord::Base
  has_many :notice
end
