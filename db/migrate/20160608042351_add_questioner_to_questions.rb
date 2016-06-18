class AddQuestionerToQuestions < ActiveRecord::Migration
  def change
    add_reference :questions, :questioner, index: true
    add_foreign_key :questions, :users, column: :questioner_id
  end
end
