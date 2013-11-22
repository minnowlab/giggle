class AddUserIdAndEvaluateIdToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :user_id, :integer
    add_column :messages, :evaluate_id, :integer
  end
end
