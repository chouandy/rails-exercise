class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

    def authenticate_owner!
      redirect_to root_path if !user_signed_in? || current_user.to_param != params[:id]
    end
end
