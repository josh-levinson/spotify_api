class AccessToken < ApplicationService
  # curl -X POST "https://accounts.spotify.com/api/token" \
  #   -H "Content-Type: application/x-www-form-urlencoded" \
  #   -d "grant_type=client_credentials&client_id=your-client-id&client_secret=your-client-secret"

  def initialize
    @cache_key = 'spotify_access_token'
    @client_id = ENV.fetch('CLIENT_ID', nil)
    @client_secret = ENV.fetch('CLIENT_SECRET',nil)
  end

  def call
    return Rails.cache.read(@cache_key) if Rails.cache.read(@cache_key)

    response = HTTParty.post("https://accounts.spotify.com/api/token", body: body, headers: { 'Content-Type' => 'application/x-www-form-urlencoded' })
    parsed_response = JSON.parse(response.body)
    access_token = parsed_response["access_token"]
    Rails.cache.write(@cache_key, access_token, expires_in: 1.hour)
    access_token
  end

  private

  def body
    {
      client_id: @client_id,
      client_secret: @client_secret,
      grant_type: "client_credentials"
    }
  end
end
