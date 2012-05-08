class ApplicationController < ActionController::Base
  include Clearance::Authentication
  #include SimpleSSLRequirement

  protect_from_forgery :only => [:create, :update, :destroy]

  #ssl_required :if => :signed_in?

  def authenticate_with_api_key
    api_key = request.headers["Authorization"] || params[:api_key]
    self.current_user = User.find_by_api_key(api_key)
  end

  def verify_authenticated_user
    if current_user.nil?
      render :text => t(:please_sign_up), :status => 401
    elsif !current_user.email_confirmed
      render :text => t(:please_confirm), :status => 403
    end
  end
end
