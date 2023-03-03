class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user
  
  validates :body, length:{maximum: 140}
end
