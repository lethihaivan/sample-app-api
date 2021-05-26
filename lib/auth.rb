require "jwt"
module Auth
  def self.issue(payload)
    JWT.encode(
      payload,
      auth_secret,
      Settings.algorithm)
  end

  def self.decode(token)
    JWT.decode(token, 
      auth_secret, 
      true,
      { algorithm: Settings.algorithm }).first
  end

  def self.auth_secret
    ENV["API_SECURE_KEY"]
  end
end
