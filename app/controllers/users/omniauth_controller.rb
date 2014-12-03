class Users::OmniauthController < Devise::OmniauthCallbacksController
  def auth
    @user = User.sign_in_with_omniauth(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect(@user, event: :authentication)
    else
      session['devise.facebook_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end

  alias_method :facebook, :auth
  alias_method :github,   :auth
end
