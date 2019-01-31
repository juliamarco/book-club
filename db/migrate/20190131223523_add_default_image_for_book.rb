class AddDefaultImageForBook < ActiveRecord::Migration[5.1]
  def change
    change_column_default :books, :cover_image, "https://www.khadims.com/media/catalog/product/cache/1/image/9df78eab33525d08d6e5fb8d27136e95/placeholder/default/big-no-image-found.jpg"
  end
end
