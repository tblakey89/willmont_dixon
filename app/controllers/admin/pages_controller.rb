class Admin::PagesController < ApplicationController
  skip_before_filter :authenticate_user!
  skip_before_filter :authorize
  def home

  end
end
