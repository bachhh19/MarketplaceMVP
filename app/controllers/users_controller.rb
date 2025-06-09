class UsersController < ApplicationController
  private

  def user_params
    params.require(:user).permit(:firstname, :lastname, :role)
  end
end
