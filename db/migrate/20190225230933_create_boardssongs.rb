class CreateBoardssongs < ActiveRecord::Migration[5.2]
  def change
    create_table :boardssongs do |t|
      t.belongs_to :board, foreign_key: true
      t.belongs_to :song, foreign_key: true

      t.timestamps
    end
  end
end
