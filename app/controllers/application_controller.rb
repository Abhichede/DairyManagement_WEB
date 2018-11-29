class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    session.delete(:return_to)
    session[:return_to] ||= request.referer
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_to root_url, :alert => exception.message }
    end
  end
end
