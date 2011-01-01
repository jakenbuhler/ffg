class PagesController < ApplicationController
  before_filter :authenticate
  
  def home
    @title = "Home"
  end
  
  def admin
    @title = "Administration"
  end

  private

    def authenticate
      deny_access unless signed_in?
    end
end
