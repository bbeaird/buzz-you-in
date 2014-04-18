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
    redirect_to root_url
  end

  def call_from_callbox
    formatted_resident_byi_number = params[:To][2..-1]
    user = User.where("resident_byi_phone_number = ?", formatted_resident_byi_number).first
    # user = User.where("resident_byi_phone_number = '6505675874'").first
    visitor_pass = VisitorPass.where("user_id = ? AND active = ?", user.id, true).first

    if visitor_pass
      render '/app/views/visitor_passes/call_from_callbox.html.erb', layout: false
      visitor_pass.update(used: true)
    else
      render '/app/views/visitor_passes/do_not_buzz_in.html.erb', layout: false
    end
  end

  def active_visitor_passes
    formatted_phone_number = params[:From][2..-1]
    active_passes = User.where("callbox_phone_number = ?", formatted_phone_number).last.visitor_passes.where("active = ? AND created_at >= ?", true, (Time.now - 4.hours)).last

    if active_passes.size >= 1
      return true
    else
      return false
    end
  end

  def sms_from_visitor
    formatted_visitor_phone_number = params[:From][2..-1]
    visitor_pass = VisitorPass.where("visitor_phone_number = ? AND created_at >= ?", formatted_visitor_phone_number, (Time.now - 4.hours)).last
    visitor_pass.update_attribute(:active, true)
  end

  private
  def visitor_pass_params
    params.require(:visitor_pass).permit(:visitor_phone_number, :user_id, :active, :created_at, :updated_at)
  end
end
