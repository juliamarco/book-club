class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :title
      t.integer :year
      t.integer :page_count
      t.string :cover_image

      t.timestamps
    end
  end
end
