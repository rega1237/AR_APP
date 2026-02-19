class Admin::BaseController < ApplicationController
  allow_unauthenticated_access
  before_action :resume_session
  before_action :require_authentication

  layout "admin"
end
