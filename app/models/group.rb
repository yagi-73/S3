class Group < ApplicationRecord
  has_many :group_users
  has_many :users, through: :group_users
  
  has_one_attached :image
  
  def get_image(weight, height)
    unless self.image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    self.image.variant(resize_to_fill: [weight,height]).processed
  end
end
