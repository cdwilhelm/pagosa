class Notice < ActiveRecord::Base
  belongs_to :status
  belongs_to :category
  belongs_to :project
  belongs_to :user
  belongs_to :impact
  belongs_to :release

  has_many :comment
end
