class Artist < ApplicationService
  def call
    artist_id = "4svpOyfmQKuWpHLjgy4cdK?si=8vwYZ0BoTvuPae5lYIlgnQ"
    @artist_url = "https://api.spotify.com/v1/artists/#{artist_id}"
    access_token = AccessToken.new.call
    headers = { 'Authorization': "Bearer #{access_token}" }
    response = HTTParty.get(@artist_url, headers: headers)
    parsed_response = JSON.parse(response.body)
  end
end
