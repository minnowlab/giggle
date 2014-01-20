class CreateNotificationRelationships < ActiveRecord::Migration
  def change
    create_table :notification_relationships do |t|
      t.belongs_to :user, index: true
      t.belongs_to :notification, index: true
      t.boolean :read, default: false

      t.timestamps
    end
  end
end
