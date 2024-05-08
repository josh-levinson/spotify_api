class SearchArtistController < ApplicationController
  def show
    result = SearchArtist.call(params[:artist_name])
    render json: result
  end
end
