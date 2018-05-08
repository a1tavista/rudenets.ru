class Post < ApplicationRecord
  include FriendlyId

  mount_uploader :preview, PreviewUploader

  acts_as_taggable
  has_paper_trail

  friendly_id :slug

  has_one :entry, as: :taxonomy, dependent: :destroy
  has_many :images, as: :imageable

  after_touch :update_canonical_url, if: :title_changed?
  before_save :update_canonical_url, if: :title_changed?

  def regenerate_preview
    html = ApplicationController.render(
      template: 'posts/preview',
      layout: 'preview',
      assigns: { post: self }
    )

    file = Tempfile.new(["template_#{self.id.to_s}", '.png'], 'tmp', encoding: 'ascii-8bit')
    blob = IMGKit.new(html, width: 1920, height: 900, javascript_delay: 1000, quality: 60).to_img(:png)
    file.write(blob)
    file.flush
    self.preview = file
    file.unlink
  end

  def regenerate_preview!
    regenerate_preview
    save
  end

  def update_canonical_url
    return if entry&.published_at.nil?
    slug_date = I18n.l(entry.published_at, format: :slug)
    slug_title = Russian.translit(title).parameterize.downcase
    regenerate_preview
    update_columns(slug: "#{slug_date}-#{slug_title}")
  end

  def self.published
    includes(:entry).where(entries: { published: true })
  end

  def self.unpublished
    includes(:entry).where(entries: { published: false })
  end

  def self.refreshed_order
    order("posts.updated_at DESC")
  end

  def is_published
    entry.published?
  end
end
