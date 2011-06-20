class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.references :project
      t.string :name
      t.text :description
      t.integer :priority
      t.decimal :progress
      t.datetime :start_date
      t.datetime :due
      t.boolean :finished, :default => false

      t.timestamps
    end
    add_index :tasks, :project_id
    add_index :tasks, :name, :unique => true
  end

  def self.down
    drop_table :tasks
  end
end
