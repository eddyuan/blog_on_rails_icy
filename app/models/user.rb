class User < ApplicationRecord
    has_secure_password
    # :nullify means clear the reference 
    # but still keep comments/posts when destroy the user
    # it should work with optional:true in the reference
    has_many :comments, dependent: :nullify
    has_many :posts, dependent: :nullify
    validates :email, presence: true, uniqueness: true
end
