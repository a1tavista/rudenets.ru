class Post
  class Alias < ApplicationRecord
    belongs_to :post

    validates :slug, presence: true
    validates :slug, uniqueness: {scope: :post_id, case_sensitive: false}
  end
end
