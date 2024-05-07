class Artist < ApplicationService
  def initialize(artist_id)
    @artist_id = artist_id
  end

  def call
    artist_url = "https://api.spotify.com/v1/artists/#{@artist_id}"
    access_token = AccessToken.call
    headers = { 'Authorization': "Bearer #{access_token}" }
    response = HTTParty.get(artist_url, headers: headers)
    parsed_response = JSON.parse(response.body)
  end
end
