class AddImagesToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :image_id, :integer
    add_index :challenges, :image_id
  end
end
