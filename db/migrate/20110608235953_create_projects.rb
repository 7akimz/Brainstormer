class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name
      t.string :location
      t.integer :client_id
      t.text :description
      t.decimal :budget, :default => 100.00
      t.text :side_notes
      t.boolean :finished, :default => false
      t.datetime :start_date
      t.datetime :due

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
