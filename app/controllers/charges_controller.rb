class ChargesController < ApplicationController
  before_action :authenticate_user!

  def create
    # Creates a Stripe Customer object, for associating
    # with the charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    # Where the magic happens
    charge = Stripe::Charge.create(
      # Stripe customer id not blocipedia id.
      customer: customer.id,
      amount: 15_00,
      description: "BigMoney Membership- #{current_user.email}",
      currency: 'usd'
    )

    update_role

    flash[:notice] = "Thanks for all the money, #{current_user.email}!
    Feel free to pay me again."
    redirect_to root_path

    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to root_path
  end

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "BigMoney Membership - #{current_user.email}",
      amount: 15_00
    }
  end

  def downgrade
    @current_user.standard!

    if @current_user.save
      flash[:notice] = "You're account has been downgraded."
      redirect_to wikis_path

    else
      flash[:alert] = "Something went wrong. Please try again."
      redirect_to root_path
    end
  end
end
