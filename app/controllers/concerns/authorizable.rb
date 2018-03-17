require 'jwt'
module Authorizable
  def authorize
    token = check_for_token
    return if token.nil?
    invalid_token_present && return unless token_valid?(token)
    begin
      decoded_token = decode_token(token)
      find_and_set_user(decoded_token)
    rescue StandardError => e
      Rails.logger.error "Authorization failed with #{e}"
      invalid_token_present
    end
  end

  def header_present?
    request.headers['Authorization'].present?
  end

  def check_for_token
    return nil unless header_present?
    pattern = /^Bearer /
    header  = request.headers['Authorization']
    token = header.gsub(pattern, '') if header && header.match(pattern)
    return nil unless token_present?(token)
    token
  end

  def token_valid?(token)
    blacklisted_tokens = Rails.cache.read('blacklisted_tokens')
    return true if blacklisted_tokens.nil?
    logged_out_tokens = Marshal.load(blacklisted_tokens)
    !logged_out_tokens.include?(token)
  end

  def token_present?(token)
    !token.nil? && !token.to_s.empty?
  end

  def decode_token(token)
    JWT.decode token, Rails.application.secrets[:secret_key_base], 'HS256'
  end

  def no_token_present
    render json: FieldError.error(nil, 'Json Web token is not present'), status: :unauthorized
  end

  def invalid_token_present
    render json: FieldError.error(nil, 'Json Web token is not valid'), status: :unauthorized
  end

  def find_and_set_user(decoded_token)
    @current_user = User.find(decoded_token.first['id'])
    @current_user_device = UserDevice.find(decoded_token.first['user_device_id'])
  end
end
