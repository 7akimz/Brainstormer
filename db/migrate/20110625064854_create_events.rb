class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.references :team
      t.string :name
      t.text :description
      t.datetime :start_at
      t.datetime :end_at
      
      t.timestamps
    end
    add_index :events, :team_id
  end

  def self.down
    drop_table :events
  end
end
