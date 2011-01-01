class PagesController < ApplicationController
  def home
    @title = "Home"
  end
  
  def admin
    @title = "Administration"
  end

end
