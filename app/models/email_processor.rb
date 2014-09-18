class EmailProcessor
  def self.process(email)
    User.create!(email: email.to, password: email.body)
  end
end