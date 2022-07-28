class Comment < ApplicationRecord
  validates :body, presence: true, length: { minimum: 10, maximum: 200 }
  belongs_to :post
  belongs_to :user, optional: true # to work with :nullify
end
