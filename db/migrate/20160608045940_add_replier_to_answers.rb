class AddReplierToAnswers < ActiveRecord::Migration
  def change
    add_reference :answers, :replier, index: true
    add_foreign_key :answers, :users, column: :replier_id
  end
end
