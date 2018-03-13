class ApplicationController < ActionController::API
  include Authorizable
  # before_action :authorize
end
