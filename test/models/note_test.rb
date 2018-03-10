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

require 'test_helper'

class NoteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
