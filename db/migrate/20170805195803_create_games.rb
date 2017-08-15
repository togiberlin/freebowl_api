class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.string :created_by, null: false
      
      t.timestamps
    end
  end
end
