# == Schema Information
#
# Table name: user_devices
#
#  id          :integer          not null, primary key
#  provider    :string
#  uid         :string
#  device_id   :string
#  device_type :string
#  jwt         :string
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class UserDevice < ApplicationRecord
  belongs_to :user
end
