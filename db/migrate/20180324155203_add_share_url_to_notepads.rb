class AddShareUrlToNotepads < ActiveRecord::Migration[5.1]
  def change
    add_column :notepads, :share_url, :string
  end
end
