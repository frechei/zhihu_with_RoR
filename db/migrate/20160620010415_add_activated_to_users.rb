class AddActivatedToUsers < ActiveRecord::Migration
  def change
  	
  	remove_column :users, :activated, :boolean
    add_column :users, :activated, :boolean, default: true
  end
end
