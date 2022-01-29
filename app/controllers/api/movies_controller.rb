class Api::MoviesController < ApplicationController

    before_action :set_movie, only: %i[show update destroy]
    before_action :check_login, only: %i[create]
    before_action :check_owner, only: %i[update destroy]
    
    
    def show
        render json: Movie.find(params[:id])
    end

    def index
        @movies = Movie.all
        render json: @movies
    end

    def create
        movie = current_user.movies.build(movie_params)

        if movie.save
            render json: movie, status: :created
        else
            render json: { errors: movie.errors }, status: :unprocessable_entity
        end
    end

    def update
        if @movie.update(movie_params)
            render json: @movie
        else
            render json: @movie.errors, status: :unprocessable_entity
        end
    end
        
    def destroy
        @movie.destroy
        head 204
    end
    
    private

    def check_owner
        head :forbidden unless @movie.user_id == current_user&.id
    end

    def set_movie
        @movie = Movie.find(params[:id])
    end

    def movie_params
        params.require(:movie).permit(:image, :title, :rate)
    end
end

    

