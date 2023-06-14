class Product < ApplicationRecord
  has_many :favorites, dependent: :destroy
  has_many_attached :images
  with_options presence: true do
      validates :name, length: { maximum: 50 }
      validates :description, length: { maximum: 1500 }
      validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 9999999 }
      validates :stock, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 99 }
      validates :color, length: { maximum: 20 }
      validates :images
  end
  validate :validate_images_count, :validate_image_file_size

  #商品がユーザーによってお気に入り登録されているか確認する
  def liked_by?(user)
      user.present? && favorites.exists?(user_id: user.id)
  end

  private

  def validate_images_count
      return unless images.attached?
    
      if images.length > 10
        images.purge
        errors.add(:images, "は10枚以内にしてください")
      end
  end

  def validate_image_file_size
      return unless images.attached?
  
      images.each do |image|
        if image.blob.byte_size > 5.megabyte
          image.purge
          errors.add(:images, "は1つのファイル5MB以内にしてください")
        end
      end
  end
end
