class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :avatar
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  genders = ['man', 'women']
  validates :username, presence: true, length: { maximum: 40 }
  validates_uniqueness_of :username, :email
  validates :gender, inclusion: { in: genders }
  validates :first_name, length: { minimum: 2 }
  validates :last_name, length: { minimum: 2 }
  validates :bio, length: { maximum: 500,
    too_long: "%{count} characters is the maximum allowed" }

  def followers
      Follower.where(following_id: self.id)
  end

  def following
      Follower.where(follower_id: self.id)
  end
end
