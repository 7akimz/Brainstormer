class CreateMembers < ActiveRecord::Migration
  def self.up
    create_table :members do |t|
      t.references :user
      t.references :team
      t.boolean   :accepted, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :members
  end
end
