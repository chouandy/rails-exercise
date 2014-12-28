class Post < ActiveRecord::Base
  include TranslatePermalink

  belongs_to :user

  acts_as_votable
  translate_permalink :title

  scope :search, -> (search) { where('title LIKE ?', "%#{search}%") }

  def to_param
    param = super
    param << "-#{permalink}" unless permalink.empty?
    param
  end

  def editable_by?(user)
    user && user == self.user
  end
end
