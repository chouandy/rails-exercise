class Post < ActiveRecord::Base
  belongs_to :user

  acts_as_votable

  def to_param
    "#{id} #{title}".to_slug.normalize.to_s
  end

  def editable_by?(user)
    user && user == self.user
  end
end
