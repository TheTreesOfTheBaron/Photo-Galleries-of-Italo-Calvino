class CreatePhotos < ActiveRecord::Migration[6.0]
  def change
    create_table :photos do |t|
      t.string :title
      t.text :description
      t.string :created_by
      t.string :visibility

      t.timestamps
    end
  end
end
