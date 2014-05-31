class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.integer :score, :default => 0
      t.integer :total_questions_answered, :default => 0
      t.string :start_time
      t.string :finished_time, :default => nil
      t.string :time_taken
      t.timestamps
    end
  end
end
