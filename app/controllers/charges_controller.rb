class ChargesController < ApplicationController
  before_action :authenticate_user!

  def create
    # Creates a Stripe Customer object, for associating
    # with the charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )
    
    stripe_id(customer)

    # Where the magic happens
    charge = Stripe::Charge.create(
      # Stripe customer id not blocipedia id.
      customer: customer.id,
      amount: 15_00,
      description: "Blocipedia Premium Membership- #{current_user.email}",
      currency: 'usd'
    )

    update_role

    flash[:notice] = "Thanks for all the money, #{current_user.email}!
    Feel free to pay me again."

    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to root_path
  end

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Blocipedia Premium Membership - #{current_user.email}",
      amount: 15_00
    }
  end

  def stripe_id(customer)
    current_user.stripe_id = customer.id
    current_user
  end

  def update_role
    current_user.premium!

    if @current_user.save
      flash[:notice] = "You're account has been upgraded."
      redirect_to wikis_path
    else
      flash[:alert] = "Something went wrong. Please try again."
    end
  end

  def downgrade
    wiki = Wiki.where(user_id: current_user.id)
    customer = Stripe::Customer.retrieve(current_user.stripe_id)
    customer.delete
    wiki.update_all(private: nil)
    current_user.standard!

    if current_user.save
      flash[:notice] = "You have successfully downgraded your account."
      redirect_to wikis_path
    else
      flash.now[:notice] = "Something went wrong. Please try again."
      redirect_to edit_user_registration_path
    end
  end
end
