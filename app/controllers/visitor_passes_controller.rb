class VisitorPassesController < ApplicationController
  include Webhookable

  after_filter :set_header

  def create
    @visitor_pass = current_user.visitor_passes.build(visitor_pass_params)
    @visitor_pass.save

    client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
    client.account.messages.create(
      from: ENV['MY_TWILIO_NUMBER'],
      to: params[:visitor_pass][:visitor_phone_number],
      body: "Hey visitor! Here is your visitor pass. Reply to this text message with 'here' when you're at the callbox."
      )
    puts "Sent message to #{ENV['MY_TWILIO_NUMBER']}!!!"
    redirect_to root_url
  end

  def call_from_callbox
    p "params: #{params}"
    p "active_visitor_passes: #{active_visitor_passes}"
    if active_visitor_passes
      name = 'Brantley'
      response = Twilio::TwiML::Response.new do |r|
        r.Say "Hello #{name}"
      end
      render '/app/views/visitor_passes/call_from_callbox.html.erb', layout: false
    # render_twiml response
    else
      render '/app/views/visitor_passes/do_not_buzz_in.html.erb', layout: false
    end
  end

  def active_visitor_passes
    VisitorPass.where("user_id = ? AND created_at >= ? AND resident_phone_number = ?", current_user.id, (Time.now - 4.hours), "{params[:user][:resident_phone_number]}") if current_user
    # VisitorPass.where
  end

  private
  def visitor_pass_params
    params.require(:visitor_pass).permit(:visitor_phone_number, :user_id, :resident_phone_number)
  end
end
