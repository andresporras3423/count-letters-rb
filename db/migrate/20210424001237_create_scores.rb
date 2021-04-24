class CreateScores < ActiveRecord::Migration[6.1]
  def change
    create_table :scores do |t|
      t.integer :questions
      t.integer :letters
      t.integer :seconds
      t.integer :corrects

      t.timestamps
    end
  end
end
