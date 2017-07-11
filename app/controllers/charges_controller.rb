class ChargesController < ApplicationController

  def new
    @stripe_btn_data = {
      key:  Rails.configuration.stripe[:publishable_key],
      description: "Premium Wiki Plan for #{current_user.username}",
      amount: Amount.default
    }
  end

  def create

    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: Amount.default,
      description: "Premium Wiki Plan - #{current_user.email}",
      currency: 'usd'
    )

    flash[:notice] = "Thanks for upgrading your account, #{current_user.usernmae}!"

    redirect_to wikis_path

  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_charge_path
  end

end

class Amount
  def self.default
    return 500
  end
end
