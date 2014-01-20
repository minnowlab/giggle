class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.belongs_to :user, index: true
      t.string :action
      t.belongs_to :trackable, index: true
      t.string :trackable_type

      t.timestamps
    end
  end
end
