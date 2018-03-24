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
require 'jwt'

class UserDevice < ApplicationRecord
  belongs_to :user, optional: true

  alias_attribute :deviceId, :device_id
  alias_attribute :deviceType, :device_type

  def generate_jwt_token!
    payload = { id: user.id, device_id: device_id, email: user.email, user_device_id: id }
    self.jwt = JWT.encode payload, Rails.application.secrets[:secret_key_base], 'HS256'
    save!
  end
end
