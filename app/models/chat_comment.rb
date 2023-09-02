class ChatComment < ApplicationRecord
  belongs_to :artist, optional: true
  belongs_to :gallary, optional: true
  belongs_to :chat_thread
end
