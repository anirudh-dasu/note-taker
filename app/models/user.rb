# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  email              :string
#  encrypted_password :string
#  username           :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class User < ApplicationRecord
  has_secure_password
  has_many :user_devices
  has_many :notes
  has_and_belongs_to_many :tags
end
