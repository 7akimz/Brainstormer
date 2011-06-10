class AddNewColumnToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :address, :string
    add_column :users, :role, :integer
    add_column :users, :username, :string
    add_column :users, :mobile_number, :string
    add_column :users, :spoken_language, :integer
    add_column :users, :country, :integer
    add_column :users, :admin, :boolean, :default => false
  end

  def self.down
    remove_column :users, :is_admin
    remove_column :users, :country
    remove_column :users, :spoken_language
    remove_column :users, :mobile_number
    remove_column :users, :username
    remove_column :users, :role
    remove_column :users, :address
  end
end
