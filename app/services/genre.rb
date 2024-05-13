class Genre < ApplicationService
  attr_reader :genre

  def initialize(genre)
    @genre = genre
  end

  def call
    genre_params = URI.encode_www_form_component(genre)
    query_params = "q=genre:#{genre_params}&type=artist&limit=20"
    genre_url = "https://api.spotify.com/v1/search?#{query_params}"
    debugger
    access_token = AccessToken.call
    headers = { 'Authorization': "Bearer #{access_token}" }
    response = HTTParty.get(genre_url, headers: headers)
    JSON.parse(response.body)
  end
end
