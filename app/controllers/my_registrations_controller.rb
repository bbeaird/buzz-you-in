class MyRegistrationsController < Devise::RegistrationsController
  def create
    super
    p 'I can do it!!!!!!!!!!!!!!!'
  end
end
