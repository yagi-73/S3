class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :book
  validates_uniqueness_of :book_id, scope: :user_id
  
  scope :week, -> { where(created_at: 1.week.ago.beginning_of_day..Time.zone.now.end_of_day) }
end
