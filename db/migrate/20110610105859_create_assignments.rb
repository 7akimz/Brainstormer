class CreateAssignments < ActiveRecord::Migration
  def self.up
    create_table :assignments do |t|
      t.references :team
      t.references :project
      t.boolean    :assigned, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :assignments
  end
end
