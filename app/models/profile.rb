class Profile < ActiveRecord::Base
  include VisibleAttributes

  belongs_to :user

  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '100x100>' },
                             url: '/system/:class/:attachment/:id_partition/:style/:hash.:extension',
                             path: ':rails_root/public/system/:class/:attachment/:id_partition/:style/:hash.:extension',
                             hash_secret: '3699a5c7ef78a8fafa58f916f4d0caad7ba471a88125afdb7cd93978eb4dc34d5d838003980340c79ef7e83049d42eecf42b5e1eac8d0a08bbf3057cff1c46b7'
  validates_attachment :avatar, content_type: { content_type: /\Aimage\/.*\Z/ },
                                size: { in: 0..1.megabytes }

  validates :cid, identity: true, allow_blank: true
  # override by model
  def invisible_attributes
    %w(id user_id)
  end
end
