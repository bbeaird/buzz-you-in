class UsersController < ApplicationController
  def add_phone_numbers
    @user = current_user
    @user.update(resident_phone_number: params[:user][:resident_phone_number], callbox_phone_number: params[:user][:callbox_phone_number])
    redirect_to root_url
  end

  def add_resident_byi_phone_number
    @user = current_user
    @user.update(resident_byi_phone_number: params[:user][:resident_byi_phone_number])
    redirect_to root_url
  end

  private
  def user_params
    params.require(:user).permit(:resident_phone_number, :callbox_phone_number, :resident_byi_phone_number, :created_at, :updated_at)
  end
end
