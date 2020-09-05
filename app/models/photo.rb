class Photo < ApplicationRecord
  # use active storage
  # When you set up a has_many relationship to have a dependent: :destroy
  # it instantiates an instance for every child class and deletes it
  # individually in case that class also has dependencies that need to be
  # destroyed. If you know for sure that children classes don’t have any
  # dependencies that need to be deleted you can just use dependent: :delete_all.
  #
  # When children records don’t have any dependencies that would have to be
  # deleted from the database use dependent: :delete_all instead of :destroy
  has_many_attached :images, dependent: :destroy_all#delete_all

  #The easiest way to sum it up is to use delete if you want records to be deleted quickly. However, if you care about models callbacks, referential integrity, or validations (for example, setting a criteria to not destroy a record unless a certain condition is “true”), then use destroy.

  #eager_load uses a left join
  # N+1 queries
  # if we tell Active Record about the associations we plan to use later,
  # it can preload the associated records with a small number of queries,
  # so that any looping can happen over records that are already in memory.
  scope :with_eager_loaded_images, -> { eager_load(images_attachments: :blob) }

  # mount_uploader :photo, PhotoUploader

  # ensure that all photos have a title and a created_by that is at least 1 character long
  # also ensure the visibility must be set to either public or private
  # ensure the photos are provided and must be in the right format
  validates :title, :created_by, presence: true, length: { minimum: 1 }
  validates :visibility, :inclusion => { :in => %w(public private), :message => "%{value} must be either public or private" }
  validates :images, presence: true,
            file_size: { less_than_or_equal_to: 2.megabyte },
            file_content_type: { allow: ['image/jpeg', 'image/jpg', 'image/png'], message: 'only %{types} are allowed' }



  # def checked=(checked)
  #   checked.reject(&:blank?)
  # end
end


#could retrieve all the comments belonging to that article
# as an array using @article.comments
# has_many :comments, dependent: :destroy
