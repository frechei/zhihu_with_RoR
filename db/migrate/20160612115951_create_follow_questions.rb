class CreateFollowQuestions < ActiveRecord::Migration
  def change
    create_table :follow_questions do |t|
      t.integer :qs_follower_id
      t.integer :followed_qs_id

      t.timestamps null: false
    end
    add_index :follow_questions, :qs_follower_id
    add_index :follow_questions, :followed_qs_id
    add_index :follow_questions, [:qs_follower_id, :followed_qs_id], unique: true
  end
end
