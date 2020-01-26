class AddReadingTimeToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :reading_time, :integer
  end
end
