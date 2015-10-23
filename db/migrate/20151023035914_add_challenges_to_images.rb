class AddChallengesToImages < ActiveRecord::Migration
  def change
    add_column :images, :challenge_id, :integer
    add_index :images, :challenge_id
  end
end
