class PagesController < ApplicationController
  def home
    if user_signed_in?
      redirect_to products_path
    else
    end
  end
end
