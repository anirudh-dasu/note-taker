require 'jwt'
module Authorizable
  def authorize
    token = check_for_token
    no_token_present && return if token.nil?
    begin
      decoded_token = decode_token(token)
      invalid_token_present && return unless token_valid?(decoded_token)
      find_and_set_user(decoded_token)
    rescue StandardError => e
      Rails.logger.error e
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

  def token_valid?(decoded_token)
    User.find(decoded_token['id']).encrypted_password == decoded_token['digest']
  end

  def token_present?(token)
    !token.nil? && !token.to_s.empty?
  end

  def decode_token(token)
    JWT.decode token, Rails.application.secrets[:secret_key_base], 'HS256'
  end

  def no_token_present
    render json: FieldError.error('Json Web token is not present'), status: :unauthorized
  end

  def invalid_token_present
    render json: FieldError.error('Json Web token is not valid'), status: :unauthorized
  end

  def find_and_set_user(decoded_token)
    @current_user = User.find(decoded_token)
  end
end
