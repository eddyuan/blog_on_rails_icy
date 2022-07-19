class Comment < ApplicationRecord
  belongs_to :post
  validates :body, length: {minimum: 3, maximum:200}
end
