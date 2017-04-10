class Entry < ApplicationRecord
  belongs_to :taxonomy, polymorphic: true
  
end
