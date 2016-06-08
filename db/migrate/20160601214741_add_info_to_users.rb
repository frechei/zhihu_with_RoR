class AddInfoToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :location, :string
  	add_column :users, :vocation, :string
  	add_column :users, :gender, :string, default: 'mars'
  	add_column :users, :company, :string
  	add_column :users, :position, :string
  	add_column :users, :education, :string
  	add_column :users, :major, :string
  	add_column :users, :statements, :string
  	add_column :users, :agreements, :integer
  	add_column :users, :thanks, :integer
  end
end
