class VisitorPassesController < ApplicationController
  before_action :set_visitor_pass, only: [:show, :edit, :update, :destroy]

  def index
    if user_signed_in? && (current_user.resident_phone_number.blank? || current_user.callbox_phone_number.blank?)
      @user = current_user
      render '_gather_phone_numbers'
    elsif user_signed_in? && current_user.stripe_customer_id.blank?
      render 'app/views/charges/new'
    # elsif current_user.resident_byi_phone_number.blank? # use this once we remove the default resident_byi_phone_number
    elsif user_signed_in? && current_user.resident_byi_phone_number == '6505675874'
      @user = current_user
      render '_buy_twilio_number'
    elsif current_user
      @visitor_passes = VisitorPass.where("user_id = ? AND created_at >= ?", current_user.id, (Time.now - 1.week))
    end
  end

  def new
    @visitor_pass = VisitorPass.new
  end

  def create
    @visitor_pass = current_user.visitor_passes.build(visitor_pass_params)

    respond_to do |format|
      if @visitor_pass.save
        send_visitor_a_visitor_pass
        format.html { redirect_to action: 'index', notice: 'Visitor pass was successfully created.' }
        format.json { render action: 'index', status: :created, location: @visitor_pass }
      else
        format.html { render action: 'new' }
        format.json { render json: @visitor_pass.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @visitor_pass.destroy
    respond_to do |format|
      format.html { redirect_to visitor_passes_url }
      format.json { head :no_content }
    end
  end

  def call_from_callbox
    # Each user will eventually have a unique BYI phone number purchased from Twilio. Current default is 6505675874.
    formatted_resident_byi_number = params[:To][2..-1]
    user = User.where("resident_byi_phone_number = ?", formatted_resident_byi_number).last
    visitor_pass_to_be_used = VisitorPass.where("user_id = ? AND active = ? AND used = ?", user.id, true, false).last

    if visitor_pass_to_be_used
      render '/app/views/visitor_passes/call_from_callbox.html.erb', layout: false
      visitor_pass_to_be_used.update(used: true)
    else
      render '/app/views/visitor_passes/do_not_buzz_in.html.erb', layout: false
    end
  end

  def sms_from_visitor
    formatted_visitor_phone_number = params[:From][2..-1]
    visitor_pass = VisitorPass.where("visitor_phone_number = ? AND created_at >= ?", formatted_visitor_phone_number, (Time.now - 4.hours)).last
    visitor_pass.update_attribute(:active, true)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_visitor_pass
      @visitor_pass = VisitorPass.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def visitor_pass_params
      params.require(:visitor_pass).permit(:visitor_phone_number, :active, :used)
    end

    def send_visitor_a_visitor_pass
    client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
        client.account.messages.create(
          from: ENV['MY_TWILIO_NUMBER'],
          to: params[:visitor_pass][:visitor_phone_number],
          body: "Hey visitor! Here is your visitor pass. Reply to this text message with 'here' when you're at the callbox."
        )
    end
end
