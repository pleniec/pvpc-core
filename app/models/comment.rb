class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  validates :user, presence: true
  validates :text, presence: true
  validates :commentable, presence: true
  validates :commentable_type, inclusion: {in: %w[User Team]}

  scope :commentable_id, ->(commentable_id) { where(commentable_id: commentable_id) }
  scope :commentable_type, ->(commentable_type) { where(commentable_type: commentable_type) }
end
