class CreateConfigGames < ActiveRecord::Migration[6.1]
  def change
    create_table :config_games do |t|
      t.string :property
      t.integer :val

      t.timestamps
    end
  end
end
