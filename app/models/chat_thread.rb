class ChatThread < ApplicationRecord
  
  has_many :chat_comments, dependent: :destroy
  accepts_nested_attributes_for :chat_comments

  validates :title, presence: true

end
