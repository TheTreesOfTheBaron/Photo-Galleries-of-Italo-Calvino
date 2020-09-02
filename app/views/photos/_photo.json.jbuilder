json.extract! photo, :id, :title, :description, :created_by, :visibility, :created_at, :updated_at
json.url photo_url(photo, format: :json)