class Notepad < ApplicationRecord
  has_ancestry
  has_paper_trail

  belongs_to :notepad_category, optional: true

  def self.current
    order(updated_at: :desc).first
  end

  def self.tree_hash
    self.arrange_serializable do |parent, children|
      {
        id: parent.id,
        label: "#{parent.name}",
        children: (children if children.present?)
      }.compact
    end
  end
end
