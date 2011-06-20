class CreateWorkers < ActiveRecord::Migration
  def self.up
    create_table :workers do |t|
      t.references :company
      t.references :team

      t.timestamps
    end
    add_index :workers, :team_id
    add_index :workers, :company_id
  end

  def self.down
    drop_table :workers
  end
end
