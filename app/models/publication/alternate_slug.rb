class Publication
  class AlternateSlug < ApplicationRecord
    belongs_to :publication

    validates :slug, presence: true
    validates :slug, uniqueness: {scope: :publication_id, case_sensitive: false}
  end
end
