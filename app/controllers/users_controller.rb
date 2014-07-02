class UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :search_for_twilio_numbers

  def gather_phone_numbers
    @user = current_user
  end

  def add_phone_numbers
    @user = current_user
    @user.update(resident_phone_number: params[:user][:resident_phone_number], callbox_phone_number: params[:user][:callbox_phone_number])
    redirect_to root_url
  end

  def search_for_twilio_number
    @user = current_user
  end

  # def add_resident_byi_phone_number
  #   @user = current_user
  #   @user.update(resident_byi_phone_number: params[:user][:resident_byi_phone_number])
  #   redirect_to root_url
  # end

  def search_for_twilio_numbers
    @client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
    search_params = {}
    search_params[:area_code] = params["area_code"] unless params["area_code"].nil? || params["area_code"].empty?
    local_numbers = @client.account.available_phone_numbers.get('US').local
    @numbers = local_numbers.list(search_params)
  end

  def buy_twilio_number
    p params
    @client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
    # @client = Twilio::REST::Client.new(ENV['TEST_TWILIO_ACCOUNT_SID'], ENV['TEST_TWILIO_AUTH_TOKEN'])
    number = @client.account.incoming_phone_numbers.create(:phone_number => "+15005550006")
    # number = @client.account.incoming_phone_numbers.create(:phone_number => params["phone_number"])
    rescue Twilio::REST::RequestError => e
      puts "************* I am rescuing you bitch!"
      # flash[:notice] = "Test flash message bia!!!!!"
      flash[:notice] = e.message
      # redirect_to root_url
  end

  private
  def user_params
    params.require(:user).permit(:resident_phone_number, :callbox_phone_number, :resident_byi_phone_number, :created_at, :updated_at)
  end
end
