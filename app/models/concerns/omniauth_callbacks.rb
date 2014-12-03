module OmniauthCallbacks
  extend ActiveSupport::Concern

  def self.included(base)
    base.class_eval do
      has_many :omniauths, dependent: :destroy

      # 1. check omniauth is existed or not.
      # 2. check omniauth's email is registered or not.
      # 3. new a user by omniauth data.
      # 4. bind omniauth service
      def self.find_or_create_by_omniauth(auth)
        unless user = User.find_by_omniauth(auth)
          unless user = User.find_by_email(auth.info.email)
            user = User.create_by_omniauth(auth)
          end
          user.bind_omniauth_service(auth)
        end
        user
      end

      def self.find_by_omniauth(auth)
        includes(:omniauths).where(omniauths: {provider: auth.provider, uid: auth.uid}).first
      end

      def self.create_by_omniauth(auth)
        User.create do |user|
          user.email        = auth.info.email
          user.password     = Devise.friendly_token[0, 20]
          user.confirmed_at = Time.now
        end
      end

      def bind_omniauth_service(auth)
        omniauths.create do |omniauth|
          omniauth.user_id  = id
          omniauth.provider = auth.provider
          omniauth.uid      = auth.uid
          omniauth.image    = auth.info.image
          omniauth.url      = auth.info.urls.Facebook if auth.provider == 'facebook'
          omniauth.url      = auth.info.urls.GitHub if auth.provider == 'github'
        end
      end
    end
  end
end
