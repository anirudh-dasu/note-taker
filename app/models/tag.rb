# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  title      :string
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tag < ApplicationRecord
  has_and_belongs_to_many :notes
  has_and_belongs_to_many :users

  before_save :create_slug

  private

  def create_slug
    self.slug = title.parameterize
  end
end
