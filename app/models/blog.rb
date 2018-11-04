class Blog < ApplicationRecord
  validates :title, presence: true, length: { in: 1..140 }
  validates :content, presence: true, length: { in: 1..140 }
  validates :user_id, {presence: true}
  validates :image, {presence: true}

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user

  mount_uploader :image, ImageBlogUploader
end
