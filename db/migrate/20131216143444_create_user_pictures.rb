class CreateUserPictures < ActiveRecord::Migration
  def change
    create_table :user_pictures do |t|
      t.string :picture
      t.string :picture_content_type
      t.integer :picture_file_size
      t.integer :user_id

      t.timestamps
    end
  end
end
