class ApplicationController < ActionController::Base
  protect_from_forgery
  include DoubanHelper
  include ApplicationHelper


end