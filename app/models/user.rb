class User < ActiveRecord::Base
  has_many :omniauths, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable,
         :omniauthable, omniauth_providers: [:facebook, :github]

  def self.sign_in_with_omniauth(auth)
    # check omniauth's email is registered or not.
    user = where(email: auth.info.email).first_or_create do |user|
      user.email        = auth.info.email
      user.password     = Devise.friendly_token[0,20]
      user.confirmed_at = Time.now
    end
    # check User's omniauth is existed or not
    omniauth = Omniauth.find_by_user_id_and_provider_and_uid(user.id, auth.provider, auth.uid)
    unless omniauth
      omniauth = Omniauth.create do |omniauth|
        omniauth.user_id  = user.id
        omniauth.provider = auth.provider
        omniauth.uid      = auth.uid
        omniauth.image    = auth.info.image
        omniauth.url      = auth.info.urls.Facebook if auth.provider == 'facebook'
        omniauth.url      = auth.info.urls.GitHub if auth.provider == 'github'
      end
    end
    # return User
    omniauth.user
  end

  def name
    self.email.split(/@/).first
  end
end
