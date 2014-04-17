class VisitorPass < ActiveRecord::Base
  belongs_to :user
  attr_accesible :active
end
