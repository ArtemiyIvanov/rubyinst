class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  validates :body, presence: true, length: { maximum: 300 }
  validates_presence_of :post_id, :user_id
end
