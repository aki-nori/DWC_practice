class RemoveCaprionFromPostImages < ActiveRecord::Migration[5.2]
  def change
    remove_column :post_images, :caprion, :text
  end
end
