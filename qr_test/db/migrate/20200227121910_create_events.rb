class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.datetime :open
      t.datetime :start_accepting
      t.datetime :end_accepting

      t.timestamps
    end
  end
end
