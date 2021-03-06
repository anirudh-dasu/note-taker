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

require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
    @user = create(:user)
  end

  it 'has a valid factory' do
    expect(@user).to be_valid
  end

  it { should validate_uniqueness_of(:email) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:username) }
  it { should have_many(:user_devices) }
end
