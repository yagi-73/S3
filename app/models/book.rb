class Book < ApplicationRecord
  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
  now = Time.current.end_of_day
  one_week_ago = now.ago(6.days).beginning_of_day
  scope :created_this_week, -> { where(created_at: one_week_ago...now) }
  
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
