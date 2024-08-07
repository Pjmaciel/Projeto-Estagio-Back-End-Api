# app/controllers/concerns/json_web_token.rb
module JsonWebToken
  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s

  class InvalidToken < StandardError; end

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    raise InvalidToken, 'Nil JSON web token' if token.nil?

    body = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new body
  rescue JWT::DecodeError => e
    raise InvalidToken, e.message
  end
end
