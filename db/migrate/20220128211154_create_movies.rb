class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :image
      t.string :title
      t.integer :rate

      t.timestamps
    end
  end
end
