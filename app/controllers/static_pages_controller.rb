class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      # @visitor_pass = current_user.visitor_passes.build
      @visitor_pass = VisitorPass.new
    end
  end

  # private
  #   def visitor_pass_params
  #     params.require(:visitor_pass).permit(:visitor_phone_number, :user_id)
  #   end
end
