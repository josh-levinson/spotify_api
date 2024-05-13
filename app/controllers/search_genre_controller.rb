class SearchGenreController < ApplicationController
  def show
    result = SearchGenre.call(params[:genre])
    render json: result
  end
end
