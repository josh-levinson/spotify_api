class SearchGenre < ApplicationService
  attr_reader :genre

  def initialize(genre)
    @genre = genre
  end

  def call
    genre_url = "https://api.spotify.com/v1/search?#{build_query}"
    access_token = AccessToken.call
    headers = { 'Authorization': "Bearer #{access_token}" }
    response = HTTParty.get(genre_url, headers: headers)
    JSON.parse(response.body)
  end

  private

  def genre_params
    genre.gsub(' ', '-')
  end

  def build_query
    "q=genre%3A#{genre_params}&type=artist&limit=20"
  end
end
