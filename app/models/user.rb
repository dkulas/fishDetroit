class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true
  
	has_many :posts, dependent: :destroy
  has_many :comments
end
