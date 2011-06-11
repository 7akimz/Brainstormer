class CreateMembers < ActiveRecord::Migration
  def self.up
    create_table :members do |t|
      t.references :user
      t.references :team
      t.boolean   :accepted, :default => false
      t.timestamps
    end
    add_index :members, :user_id
    add_index :members, :team_id
  end

  def self.down
    drop_table :members
  end
end
