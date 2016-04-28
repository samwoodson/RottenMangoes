class MoviesController < ApplicationController
  autocomplete :movie, :title, :extra_data => [:director], full: true

  # def autocomplete_product_name
  #   movies = Movie.title_search(params[:movie][:title])
  #   render :json => movies.map { |movie| {:title => movie.title, :director => movie.director} }
  # end

  def index
    if params[:movie]
      min_value, max_value = params[:movie][:duration].split('-')
      @movies = Movie.title_search(params[:movie][:title])
      .duration_search(min_value, max_value)
      .page(params[:page])
    else
      @movies = Movie.all.order("random()").page(params[:page])
    end
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end 

  def update
    @movie = Movie.find(params[:id])

    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  # def search
  #   @search_results = Movie.where("title LIKE ?", "%#{params[:q]}%")
  #   redirect_to movies_search_path
  # end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  protected

  def movie_params
    params.require(:movie).permit(
      :image, :title, :release_date, :director, :runtime_in_minutes, :poster_image_url, :description
    )
  end

end
