class Photo < ApplicationRecord

  has_many_attached :images, dependent: :destroy_all

  #eager_load
  scope :with_eager_loaded_images, -> { eager_load(images_attachments: :blob) }

  # ensure that all photos have a title and a created_by that is at least 1 character long
  # also ensure the visibility must be set to either public or private
  # ensure the photos are provided and must be in the right format
  validates :title, :created_by, presence: true, length: { minimum: 1 }
  validates :visibility, :inclusion => { :in => %w(public private), :message => "%{value} must be either public or private" }
  validates :images, presence: true,
            file_size: { less_than_or_equal_to: 2.megabyte },
            file_content_type: { allow: ['image/jpeg', 'image/jpg', 'image/png'], message: 'only %{types} are allowed' }
end
