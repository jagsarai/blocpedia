class ChargesController < ApplicationController
require 'Wiki'
  def new

    if current_user.standard?
      @stripe_btn_data = {
        key:  Rails.configuration.stripe[:publishable_key],
        description: "Premium Wiki Plan for #{current_user.username}",
        amount: Amount.default
      }
    else
      flash[:alert] = "You are about to unsubscribe, please read the instructions below carefully!"
    end

  end

  def create
    if current_user.standard?
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

      flash[:notice] = "Thanks for upgrading your account, #{current_user.username}!"


      redirect_to wikis_path
    else
      current_user.update! role: :standard
      current_user.wikis.each do |wiki|
        wiki.update! private: :false
      end
      flash[:alert] = "Your are now using a standard account"

      redirect_to wikis_path
    end

    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
    end

end


class Amount
  def self.default
    return 1500
  end
end
