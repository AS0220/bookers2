class Book < ApplicationRecord
  has_one_attached :image
    validates :title, presence: true
    validates :body, presence: true, length: {maximum: 200}
  belongs_to :user
end
