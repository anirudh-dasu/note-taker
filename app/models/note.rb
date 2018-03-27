# == Schema Information
#
# Table name: notes
#
#  id         :integer          not null, primary key
#  title      :string
#  content    :text
#  url        :string
#  user_id    :integer
#  kind       :string
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Note < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :tags
  alias_attribute :author, :user

  cattr_accessor(:paginates_per) { 10 }

  validates :title, presence: true, length: { minimum: 3 }
  validates :author, presence: true

  before_save :create_slug

  scope :author, ->(user_id) { where(user_id: user_id) }
  scope :latest, -> { order(updated_at: :desc) }
  scope :tag_slug, ->(tag_slug) { joins(:tags).where(tags: { slug: tag_slug }) }
  scope :tag_id, ->(tag_id) { joins(:tags).where(tags: { id: tag_id }) }
  scope :with_tags, -> { includes(:tags) }

  def self.paginate(offset)
    offset(offset).limit(paginates_per)
  end

  private

  def create_slug
    self.slug = title.parameterize
  end
end
