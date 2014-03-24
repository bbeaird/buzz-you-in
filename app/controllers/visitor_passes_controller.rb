class VisitorPassesController < ApplicationController
  def create
    @visitor_pass = current_user.visitor_passes.build(visitor_pass_params)
    @visitor_pass.save
    redirect_to root_url
  end

  private
    def visitor_pass_params
      params.require(:visitor_pass).permit(:visitor_phone_number, :user_id)
    end
end
