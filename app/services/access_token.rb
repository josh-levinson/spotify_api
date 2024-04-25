require 'debug'

class AccessToken
  # curl -X POST "https://accounts.spotify.com/api/token" \
  #   -H "Content-Type: application/x-www-form-urlencoded" \
  #   -d "grant_type=client_credentials&client_id=your-client-id&client_secret=your-client-secret"

  def call
    @client_id = ENV.fetch('CLIENT_ID', nil)
    @client_secret = ENV.fetch('CLIENT_SECRET',nil)
    @spotify_url = "https://accounts.spotify.com/api/token"

    response = HTTParty.post(@spotify_url, body: body, headers: { 'Content-Type' => 'application/x-www-form-urlencoded' })
    response.body
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
