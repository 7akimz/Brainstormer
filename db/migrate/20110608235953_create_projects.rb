class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name
      t.string :address
      t.integer :client_id
      t.text :description
      t.decimal :budget, :default => 100.00
      t.text :side_notes
      t.boolean :finished, :default => false
      t.datetime :start_date
      t.datetime :due

      t.timestamps
    end
    add_index :projects, :client_id
    add_index :projects, :name, :unique => true
  end

  def self.down
    drop_table :projects
  end
end
