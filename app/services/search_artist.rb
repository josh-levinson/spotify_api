class SearchArtist < ApplicationService
  def initialize(artist_name)
    @artist_name = artist_name
  end

  def call
    search_url = "https://api.spotify.com/v1/search?q=#{@artist_name}&type=artist"
    access_token = AccessToken.call
    headers = { 'Authorization': "Bearer #{access_token}" }
    response = HTTParty.get(search_url, headers: headers)
    parsed_response = JSON.parse(response.body)
  end
end
