class User < ActiveRecord::Base
  has_many :visitor_passes

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
end
