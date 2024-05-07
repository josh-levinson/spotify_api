class AccessToken
  CACHE_KEY = 'spotify_access_token'.freeze

  # curl -X POST "https://accounts.spotify.com/api/token" \
  #   -H "Content-Type: application/x-www-form-urlencoded" \
  #   -d "grant_type=client_credentials&client_id=your-client-id&client_secret=your-client-secret"

  def call
    return Rails.cache.read(CACHE_KEY) if Rails.cache.read(CACHE_KEY)

    @client_id = ENV.fetch('CLIENT_ID', nil)
    @client_secret = ENV.fetch('CLIENT_SECRET',nil)
    @spotify_url = "https://accounts.spotify.com/api/token"

    response = HTTParty.post(@spotify_url, body: body, headers: { 'Content-Type' => 'application/x-www-form-urlencoded' })
    parsed_response = JSON.parse(response.body)
    access_token = parsed_response["access_token"]
    Rails.cache.write(CACHE_KEY, access_token, expires_in: 1.hour)
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
