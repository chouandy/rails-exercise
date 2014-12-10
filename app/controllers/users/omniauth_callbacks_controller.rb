class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def auth
    @user = User.find_or_create_by_omniauth(env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect(@user, event: :authentication)
    else
      session['devise.omniauth_data'] = env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end

  User.omniauth_providers.each do |provider|
    alias_method provider, :auth
  end
end
