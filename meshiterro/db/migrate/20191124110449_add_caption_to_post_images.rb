class AddCaptionToPostImages < ActiveRecord::Migration[5.2]
  def change
    add_column :post_images, :caption, :text
  end
end
