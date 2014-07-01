class UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :search_for_twilio_numbers

  def add_phone_numbers
    @user = current_user
    @user.update(resident_phone_number: params[:user][:resident_phone_number], callbox_phone_number: params[:user][:callbox_phone_number])
    redirect_to root_url
  end

  # def add_resident_byi_phone_number
  #   @user = current_user
  #   @user.update(resident_byi_phone_number: params[:user][:resident_byi_phone_number])
  #   redirect_to root_url
  # end

  def search_for_twilio_numbers
    client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
    search_params = {}
    search_params[:area_code] = params["area_code"] unless params["area_code"].nil? || params["area_code"].empty?
    local_numbers = client.account.available_phone_numbers.get('US').local
    @numbers = local_numbers.list(search_params)
  end

  private
  def user_params
    params.require(:user).permit(:resident_phone_number, :callbox_phone_number, :resident_byi_phone_number, :created_at, :updated_at)
  end
end
