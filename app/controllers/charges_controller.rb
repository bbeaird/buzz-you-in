class ChargesController < ApplicationController
  def new
    @user = current_user
  end

  def create
    @user = current_user
    token = params[:stripeToken]

    customer = Stripe::Customer.create(
      :card => token,
      :plan => 'silver',
      :email => 'example@stripe.com'
    )

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to charges_path
    else
      current_user.update(stripe_customer_id: customer.id)
      redirect_to user_visitor_passes_url(@user)
  end
end
