class CreateSongs < ActiveRecord::Migration[5.2]
  def change
    create_table :songs do |t|
      t.string :name
      t.integer :billboard_rank
      t.string :album
      t.integer :track_number
      t.integer :year
      t.belongs_to :artist, foreign_key: true

      t.timestamps
    end
  end
end
