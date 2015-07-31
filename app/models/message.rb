class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :conversation

  validates :user, presence: true
  validates :conversation, presence: true
  validates :text, presence: true
end
