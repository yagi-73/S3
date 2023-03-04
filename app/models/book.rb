class Book < ApplicationRecord
  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
  scope :created_today, -> { where(created_at: Time.zone.now.all_day) }
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) }
  now = Time.current.end_of_day
  one_week_ago = now.ago(6.days).beginning_of_day
  two_week_ago = one_week_ago.ago(7.days)
  scope :created_this_week, -> { where(created_at: one_week_ago...now) }
  scope :created_last_week, -> { where(created_at: two_week_ago...one_week_ago.yesterday.end_of_day) }
  
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
