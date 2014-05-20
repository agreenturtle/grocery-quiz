class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :test_id
      t.string :question_name
      t.string :applicant_answer

      t.timestamps
    end
  end
end
