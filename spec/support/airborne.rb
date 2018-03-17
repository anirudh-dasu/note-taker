Airborne.configure do |config|
  config.base_url = 'http://localhost:3000'
  config.headers = { 'Authorization' => 'Bearer asdasdas' }
  config.match_expected_default = true
  config.match_actual_default = false
end
