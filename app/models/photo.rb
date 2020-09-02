class Photo < ApplicationRecord
  # use active storage
  has_one_attached :image

# ensure that all photos have a title that is at least 1 character long
  validates :title, presence: true,
            length: { minimum: 1 }
end


#could retrieve all the comments belonging to that article
# as an array using @article.comments
# has_many :comments, dependent: :destroy
