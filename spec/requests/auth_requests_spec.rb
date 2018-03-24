require 'rails_helper'

RSpec.describe 'Auth', type: :requests do
  it 'does not return data unless logged in' do
    headers = { 'Authorization' => 'Bearer abcde' }
    post '/graphql', params: nil, headers: headers
    expect_status(401)
  end
end
