class Publication
  class Reaction < ApplicationRecord
    self.table_name_prefix = "publication"

    belongs_to :publication
    validates :username, uniqueness: {scope: :publication_id}
  end
end
