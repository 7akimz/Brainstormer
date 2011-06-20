class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.references :task
      t.string :name
      t.text :description

      t.timestamps
    end
    add_index :comments, :task_id
  end

  def self.down
    drop_table :comments
  end
end
