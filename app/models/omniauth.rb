class Omniauth < ActiveRecord::Base
  include VisibleAttributes

  belongs_to :user

  # override by model
  def invisible_attributes
    %w(id user_id)
  end
end
