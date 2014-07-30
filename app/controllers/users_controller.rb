class UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :search_for_twilio_numbers

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to visitor_passes_path
    else
      render 'edit'
    end
  end

  def gather_phone_numbers
    @user = current_user
  end

  def add_phone_numbers
    @user = current_user
    @user.update(resident_phone_number: params[:user][:resident_phone_number], callbox_phone_number: params[:user][:callbox_phone_number])
    tracker = Mixpanel::Tracker.new(ENV['MIXPANEL_TOKEN'])
    tracker.track(current_user.id, 'Added phone numbers!')
    redirect_to root_url
  end

  def search_for_twilio_number
  end

  def send_area_code
    @user = current_user
    search_params = {}
    search_params[:area_code] = params["area_code"] unless params["area_code"].nil? || params["area_code"].empty?
    local_numbers = $twilio.account.available_phone_numbers.get('US').local
    $numbers = local_numbers.list(search_params)
    LocalNumbers.in_area_code(params[:area_code])
    # render '/app/views/users/list_twilio_numbers'
    redirect_to(action: 'list_twilio_numbers')
  end

  def list_twilio_numbers
    # @user = current_user
    # p @user
    # @client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
    # search_params = {}
    # search_params[:area_code] = params["area_code"] unless params["area_code"].nil? || params["area_code"].empty?
    # local_numbers = @client.account.available_phone_numbers.get('US').local
    # @numbers = local_numbers.list(search_params)
    # render '/app/views/users/list_twilio_numbers'
    # redirect_to root_url(@user)
  end

  def buy_twilio_number
    @client = Twilio::REST::Client.new(ENV['TEST_TWILIO_ACCOUNT_SID'], ENV['TEST_TWILIO_AUTH_TOKEN'])
    number = @client.account.incoming_phone_numbers.create(:phone_number => "+15005550006")
    # @user.update(resident_byi_phone_number: params["phone_number"])
    # number = @client.account.incoming_phone_numbers.create(:phone_number => params["phone_number"])
    redirect_to action: save_bought_number
    rescue Twilio::REST::RequestError => e
      puts "************* I am rescuing you bitch!"
      # flash[:notice] = "Test flash message bia!!!!!"
      flash[:notice] = e.message
      redirect_to action: save_bought_number
  end

  def save_bought_number
    @user = current_user
    @user.update(resident_byi_phone_number: params["phone_number"])
  end

  # def add_resident_byi_phone_number
  #   @user = current_user
  #   @user.update(resident_byi_phone_number: params[:user][:resident_byi_phone_number])
  #   redirect_to root_url
  # end

  private
  def user_params
    params.require(:user).permit(:email, :resident_phone_number, :callbox_phone_number, :resident_byi_phone_number, :created_at, :updated_at)
  end
end
