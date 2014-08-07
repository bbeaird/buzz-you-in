class User < ActiveRecord::Base
  has_many :visitor_passes
end
