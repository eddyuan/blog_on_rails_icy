class User < ApplicationRecord
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  has_secure_password
  # :nullify means clear the reference
  # but still keep comments/posts when destroy the user
  # it should work with optional:true in the reference
  has_many :comments, dependent: :nullify
  has_many :posts, dependent: :nullify
  validates :name, presence: true
  validates :email,
            presence: true,
            uniqueness: true,
            format: {
              with: URI::MailTo::EMAIL_REGEXP
            }
  validates :password,
            presence: true,
            confirmation: true,
            length: {
              within: 6..40
            },
            on: :create
  validates :password,
            confirmation: true,
            length: {
              within: 6..40
            },
            allow_blank: true,
            on: :update
end
