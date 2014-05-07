class VisitorPassesController < ApplicationController
  before_action :set_visitor_pass, only: [:show, :edit, :update, :destroy]

  # GET /visitor_passes
  # GET /visitor_passes.json
  def index
    @visitor_passes = VisitorPass.all
    # @recent_visitor_passes = VisitorPass.where("user_id = ? AND created_at >= ?", current_user.id, (Time.now - 1.week))
  end

  # GET /visitor_passes/1
  # GET /visitor_passes/1.json
  def show
  end

  # GET /visitor_passes/new
  def new
    @visitor_pass = VisitorPass.new
  end

  # POST /visitor_passes
  # POST /visitor_passes.json
  def create
    # @visitor_pass = VisitorPass.new(visitor_pass_params)
    @visitor_pass = current_user.visitor_passes.build(visitor_pass_params)

    respond_to do |format|
      if @visitor_pass.save
        client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
        client.account.messages.create(
          from: ENV['MY_TWILIO_NUMBER'],
          to: params[:visitor_pass][:visitor_phone_number],
          body: "Hey visitor! Here is your visitor pass. Reply to this text message with 'here' when you're at the callbox."
        )
        format.html { redirect_to root_url, notice: 'Visitor pass was successfully created.' }
        format.json { render action: 'index', status: :created, location: @visitor_pass }
      else
        format.html { render action: 'new' }
        format.json { render json: @visitor_pass.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /visitor_passes/1
  # PATCH/PUT /visitor_passes/1.json
  def update
    respond_to do |format|
      if @visitor_pass.update(visitor_pass_params)
        format.html { redirect_to @visitor_pass, notice: 'Visitor pass was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @visitor_pass.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /visitor_passes/1
  # DELETE /visitor_passes/1.json
  def destroy
    @visitor_pass.destroy
    respond_to do |format|
      format.html { redirect_to visitor_passes_url }
      format.json { head :no_content }
    end
  end

  def call_from_callbox
    formatted_resident_byi_number = params[:To][2..-1]
    user = User.where("resident_byi_phone_number = ?", formatted_resident_byi_number).first
    # user = User.where("resident_byi_phone_number = '6505675874'").first
    visitor_pass_to_be_used = VisitorPass.where("user_id = ? AND active = ?", user.id, true).last

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
  end
