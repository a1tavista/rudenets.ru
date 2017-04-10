class CreateLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :links do |t|
      t.string :url, null: false
      t.string :summary
      t.string :og_title
      t.string :og_type
      t.string :og_url
      t.string :og_description
      t.string :og_images
      t.timestamps
    end
  end
end
