class CreateBoards < ActiveRecord::Migration[5.2]
  def change
    create_table :boards do |t|
      t.string :name
      t.integer :year
      t.text :description

      t.timestamps
    end
  end
end
