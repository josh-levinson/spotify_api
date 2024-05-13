class Artist < ApplicationService
  attr_reader :artist_id

  def initialize(artist_id)
    @artist_id = artist_id
  end

  def call
    artist_url = "https://api.spotify.com/v1/artists/#{artist_id}"
    access_token = AccessToken.call
    headers = { 'Authorization': "Bearer #{access_token}" }
    response = HTTParty.get(artist_url, headers: headers)
    JSON.parse(response.body)
  end
end
