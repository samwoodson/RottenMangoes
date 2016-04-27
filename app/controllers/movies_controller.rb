class MoviesController < ApplicationController
  def index
    if params[:duration]
      min_value, max_value = params[:duration].split('-')
    end

    if params[:title] || params[:director] || params[:duration]
      @movies = Movie.title_search(params[:title]).director_search(params[:director]).duration_search(min_value, max_value)
    else
      @movies = Movie.all
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
