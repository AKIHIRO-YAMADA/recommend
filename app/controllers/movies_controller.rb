class MoviesController < ApplicationController
  def index
  	 @movies = Movie.all
  end

  def show
  	 @movie = Movie.find(params[:id])
     @movie_comment = MovieComment.new
  	 @user = User.find_by(id: params[:id])

  end

  def edit
     @movie = Movie.find(params[:id])
  end

  def new
     @movie = Movie.new
  end

  def create
  	 @movie = current_user.movies.build(movie_params)
     if @movie.save
      redirect_to @movie
     else
      @movies = Movie.all
      render :index
    end
   end

  def update
     @movie = Movie.find(params[:id])
     if @movie.update(movie_params)
      redirect_to @movie
     else
     render 'edit'
     end
  end

  def destroy
     @movie = Movie.find(params[:id])
     @movie.destroy
     redirect_to movies_url
  end
  def search
    byebug
    # application controllerで生成した@qを利用して検索する
    @q_movies = @q.result.page(params[:page]).per(10)
    render :index
  end

  private
  def movie_params
      params.require(:movie).permit(:title, :image, :heading, :impression, :category_id, :spoiler)
  end
end

