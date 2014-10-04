class HomeController < ApplicationController

  before_action :require_user, only: :restricted

  def index
  end

  def restricted
  end

end
