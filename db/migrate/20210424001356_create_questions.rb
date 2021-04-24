class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.string :letter
      t.boolean :correct

      t.timestamps
    end
  end
end
