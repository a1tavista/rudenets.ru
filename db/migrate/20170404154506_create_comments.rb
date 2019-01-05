class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments, &:timestamps
  end
end
