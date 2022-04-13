class User < ApplicationRecord
  validates_presence_of :user_name, 
                        :email, 
                        :password_digest, require: true

  validates :user_name, uniqueness: true
  validates :email, uniqueness: true
  validates_length_of :password, minimum: 6

  has_secure_password
end
