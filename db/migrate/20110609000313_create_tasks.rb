class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.integer :project_id
      t.integer :priority
      t.decimal :progress
      t.string :name
      t.text :description
      t.boolean :finished, :default => false
      t.datetime :start_date
      t.datetime :due

      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
