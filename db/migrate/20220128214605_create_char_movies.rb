class CreateCharMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :char_movies do |t|
      t.belongs_to :character, null: false, foreign_key: true
      t.belongs_to :movie, null: false, foreign_key: true

      t.timestamps
    end
  end
end
