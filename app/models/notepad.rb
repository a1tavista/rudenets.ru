class Notepad < ApplicationRecord
  belongs_to :notepad_category, optional: true

  def self.current
    order(updated_at: :desc).first
  end
end
