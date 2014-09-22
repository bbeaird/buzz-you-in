class EmailProcessor
  def self.process(email)
    User.create!(email: email.to, password: email.body)
    p "********** You just created a user with email bithc!!!!"
  end
end