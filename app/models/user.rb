class User < ActiveRecord::Base
  has_many :visitor_passes

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end
end
