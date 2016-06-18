class CreateFollowTopics < ActiveRecord::Migration
  def change
    create_table :follow_topics do |t|
      t.integer :tp_follower_id
      t.integer :followed_tp_id

      t.timestamps null: false
    end
    add_index :follow_topics, :tp_follower_id
    add_index :follow_topics, :followed_tp_id
    add_index :follow_topics, [:tp_follower_id, :followed_tp_id], unique: true
  end
end
