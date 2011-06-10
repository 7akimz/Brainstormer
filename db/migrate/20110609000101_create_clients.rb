class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.string :name
      t.string :email
      t.string :contact
      t.string :address

      t.timestamps
    end
  end

  def self.down
    drop_table :clients
  end
end
