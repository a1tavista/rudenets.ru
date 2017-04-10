class Link < ApplicationRecord
  has_one :entry, as: :taxonomy
end
