class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      # @visitor_pass = current_user.visitor_passes.build
      @visitor_pass = VisitorPass.new
      # @active_visitor_passes = current_user.visitor_passes
      @active_visitor_passes = VisitorPass.where("user_id = ? AND created_at >= ?", current_user.id, (Time.now - 4.hours))
    end

    session["counter"] ||= 0
    sms_count = session["counter"]
    if sms_count == 0
      message = "Hello, thanks for the new message."
    else
      message = "Hello, thanks for message number #{sms_count + 1}"
    end
    twiml = Twilio::TwiML::Response.new do |r|
      r.Sms message
    end
    session["counter"] += 1
    p twiml.text
  end

  # private
  #   def visitor_pass_params
  #     params.require(:visitor_pass).permit(:visitor_phone_number, :user_id)
  #   end
end
