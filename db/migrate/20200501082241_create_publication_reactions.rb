class CreatePublicationReactions < ActiveRecord::Migration[5.2]
  def change
    create_table :publication_reactions do |t|
      t.belongs_to :publication, foreign_key: true, index: true
      t.string :username, index: true
      t.jsonb :data

      t.index [:publication_id, :username]
      t.timestamps
    end
  end
end
