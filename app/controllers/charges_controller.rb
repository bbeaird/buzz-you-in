class ChargesController < ApplicationController
  def new
  end

  def create
    token = params[:stripeToken]

    customer = Stripe::Customer.create(
      :card => token,
      :plan => 'silver',
      :email => 'example@stripe.com'
    )

    @user = current_user
    @user.update(stripe_customer_id: customer.id)

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to charges_path

    # redirect_to controller: 'visitor_passes', action: 'index'
  end
end
