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

  validates_presence_of :title
  validates_presence_of :author

  scope :author, ->(user_id) { where(user_id: user_id) }
  scope :latest, -> { order(updated_at: :desc) }
  scope :tag_slug, ->(tag_slug) { joins(:tags).where(tags: { slug: tag_slug }) }
  scope :tag_id, ->(tag_id) { joins(:tags).where(tags: { id: tag_id }) }
  # scope :offset, -> (offset){offset(offset)}
  # scope :limit, -> (limit){limit(limit)}
end
