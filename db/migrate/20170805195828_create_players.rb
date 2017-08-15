class CreatePlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :players do |t|
      t.references :game, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
