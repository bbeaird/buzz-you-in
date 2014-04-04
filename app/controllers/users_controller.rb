class UsersController < ApplicationController
  def add_phone_numbers
    @user = current_user
    @user.update(phone_number: params[:user][:phone_number], callbox_phone_number: params[:user][:callbox_phone_number])
    redirect_to root_url
  end
end
