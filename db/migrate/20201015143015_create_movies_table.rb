class CreateMoviesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.string :name
      t.string :director
      t.integer :rating
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
