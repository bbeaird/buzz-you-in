class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      @user = current_user
      # @visitor_pass = current_user.visitor_passes.build
      @visitor_pass = VisitorPass.new
      @active_visitor_passes = VisitorPass.where("user_id = ? AND created_at >= ? AND active = ? AND used = ?", current_user.id, (Time.now - 4.hours), true, false)
      @inactive_visitor_passes = VisitorPass.where("user_id = ? AND active = ? AND used = ?", current_user.id, false, false)
      @used_visitor_passes = VisitorPass.where("user_id = ? AND used = ?", current_user.id, true)
    end
  end

  # private
  #   def visitor_pass_params
  #     params.require(:visitor_pass).permit(:visitor_phone_number, :user_id)
  #   end
end
