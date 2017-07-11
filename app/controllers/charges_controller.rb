class ChargesController < ApplicationController

  def new

    if current_user.standard?
      @stripe_btn_data = {
        key:  Rails.configuration.stripe[:publishable_key],
        description: "Premium Wiki Plan for #{current_user.username}",
        amount: Amount.default
      }
    else
      flash[:alert] = "You are already a premium member!!"
      redirect_to wikis_path
    end

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

    current_user.update! role: :premium

    flash[:notice] = "Thanks for upgrading your account, #{current_user.username}!, #{current_user.role}"


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
