class UsersController < ApplicationController

  def downgrade
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
