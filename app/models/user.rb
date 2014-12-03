class User < ActiveRecord::Base
  include OmniauthCallbacks

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable,
         :omniauthable, omniauth_providers: [:facebook, :github]

  def name
    self.email.split(/@/).first
  end
end
