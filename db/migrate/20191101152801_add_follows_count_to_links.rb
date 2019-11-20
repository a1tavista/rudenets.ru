class AddFollowsCountToLinks < ActiveRecord::Migration[5.2]
  def change
    add_column :links, :follows_count, :integer, null: false, default: 0
  end
end
