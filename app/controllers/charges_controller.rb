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

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to charges_path
    else
      current_user.update(stripe_customer_id: customer.id)
      redirect_to visitor_passes_url
  end
end
