class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :test_question
      t.string :option_one
      t.string :option_two
      t.string :option_three
      t.string :option_four

      t.timestamps
    end
  end
end
