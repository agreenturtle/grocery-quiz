class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.string :score
      t.integer :total_questions_answered
      t.string :start_time
      t.string :finished_time
      t.string :time_taken
      t.timestamps
    end
  end
end
