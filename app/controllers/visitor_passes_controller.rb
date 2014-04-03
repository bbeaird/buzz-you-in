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
    name = 'Brantley'
    response = Twilio::TwiML::Response.new do |r|
      r.Say "Hello #{name}"
      # r.Dial.Number
    end
    render '/app/views/visitor_passes/call_from_callbox.html.erb', layout: false
    # render_twiml response
  end

  private
  def visitor_pass_params
    params.require(:visitor_pass).permit(:visitor_phone_number, :user_id)
  end
end
