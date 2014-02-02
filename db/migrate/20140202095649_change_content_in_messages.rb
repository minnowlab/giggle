class ChangeContentInMessages < ActiveRecord::Migration
  def up
    change_column :messages, :content, :text
  end

  def down
    change_column :messages, :content, :string
  end
end
