class Publication < ApplicationRecord
  enum type: {
    'Publication::Post': "Publication::Post",
    'Publication::Link': "Publication::Link",
    'Publication::ChannelPost': "Publication::ChannelPost",
  }

  has_many :aliases, class_name: "Post::Alias", dependent: :destroy
  has_many :reactions, class_name: "Publication::Reaction"

  include ImageUploader::Attachment(:preview_image)
  include CoverUploader::Attachment(:cover_image)

  scope :posts, -> { where(type: "Publication::Post") }
  scope :links, -> { where(type: "Publication::Link") }

  scope :published, -> { where("published_at <= ?", Time.current) }
  scope :planned, -> { where("published_at >= ?", Time.current) }

  scope :sorted_by_creation_time, -> { order(created_at: :desc) }
  scope :sorted_by_publishing_time, -> { order(published_at: :desc) }

  def self.primary_key_as_foreign
    ["publication", primary_key].join("_").to_sym
  end

  def typed_instance
    new_record? ? type.constantize.new(attributes) : type.constantize.find(id)
  end

  def post?
    type == "Publication::Post"
  end

  def link?
    type == "Publication::Link"
  end

  def channel_post?
    type == "Publication::ChannelPost"
  end

  def taxonomy
    self
  end

  def taxonomy_type
    type.to_s.demodulize
  end

  def entry
    self
  end
end
