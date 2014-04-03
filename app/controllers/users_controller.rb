class UsersController < ApplicationController
  def add_phone_number
    @user = current_user
    @user.update(phone_number: params[:user][:phone_number])
    redirect_to root_url
  end
end
