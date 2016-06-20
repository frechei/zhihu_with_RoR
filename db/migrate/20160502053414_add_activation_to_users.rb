class AddActivationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :activation_digest, :string
    # 由于没有信用卡，heroku的addon先不能用，default先改成true
    # add_column :users, :activated, :boolean, default: false
    add_column :users, :activated, :boolean, default: false
    add_column :users, :activated_at, :datetime
  end
end
