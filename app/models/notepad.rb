class Notepad < ApplicationRecord
  has_ancestry

  has_paper_trail if: proc { |notepad| notepad.should_create_new_version? }

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

  def should_create_new_version?
    version = versions.last
    last_update_time = version&.created_at || (Time.current - 10.minutes)
    Time.current - last_update_time > 1.minute
  end
end
