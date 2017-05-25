class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery with: :exception

  def update_role
    @current_user.premium!

    if @current_user.save
      flash[:notice] = "You're account has been upgraded."
      redirect_to wikis_path
    else
      flash[:alert] = "Something went wrong. Please try again."
    end
  end
end
