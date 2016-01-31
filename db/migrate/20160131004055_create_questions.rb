class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :issue
      t.text :description
      t.string :topic

      t.timestamps null: false
    end
  end
end
