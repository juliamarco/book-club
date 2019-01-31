class RenameReviewsTextColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :reviews, :text, :review_text
  end
end
