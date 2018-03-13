# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string
#  password_digest :string
#  username        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  has_secure_password
  has_many :user_devices, dependent: :destroy
  has_many :notes
  has_and_belongs_to_many :tags

  validates_uniqueness_of :email
  validates_uniqueness_of :username

  scope :with_token, ->(token) { joins(:user_devices).where(user_devices: { jwt: token }) }

  def update_with_password(password: nil, password_confirmation: nil, current_password: nil)
    if authenticate(current_password)
      errors.add(:base, "Password can't be blank") && (return false) if password.blank?
      update(password: password, password_confirmation: password_confirmation)
    else
      errors.add(:current_password, 'Invalid password')
      false
    end
  end
end
