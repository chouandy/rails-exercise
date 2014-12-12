class User < ActiveRecord::Base
  include OmniauthCallbacks
  include VisibleAttributes

  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile

  has_many :posts, dependent: :destroy

  acts_as_voter

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable,
         :omniauthable, omniauth_providers: [:facebook, :github, :linkedin]

  def username
    self.email.split(/@/).first
  end

  def to_param
    "#{id} #{username}".to_slug.normalize.to_s
  end

  # override by model
  def invisible_attributes
    %w(id encrypted_password reset_password_token reset_password_sent_at remember_created_at confirmation_token confirmed_at confirmation_sent_at unconfirmed_email)
  end
end
