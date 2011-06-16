class CreateAssignments < ActiveRecord::Migration
  def self.up
    create_table :assignments do |t|
      t.references :team
      t.references :project
      t.boolean    :assigned, :default => false
      t.string     :assigned_by

      t.timestamps
    end
    add_index :assignments, :team_id
    add_index :assignments, :project_id
  end

  def self.down
    drop_table :assignments
  end
end
