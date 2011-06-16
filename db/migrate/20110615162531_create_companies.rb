class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
      t.string :name
      t.string :telephone
      t.string :fax
      t.string :email
      t.integer :country
      t.string :address
      t.integer :employees_number
      t.decimal :capital, :default => 5000.0

      t.timestamps
    end
    add_index :companies, :name, :unique => true
  end

  def self.down
    drop_table :companies
  end
end
