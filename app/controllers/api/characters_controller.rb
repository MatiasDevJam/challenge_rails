class Api::CharactersController < ApplicationController
    before_action :set_character, only: %i[show update destroy]
    before_action :check_login, only: %i[create]
    before_action :check_owner, only: %i[update destroy]
  
    
    def show
        render json: Character.find(params[:id])
    end

    def index
        @character = Character.search(params)
        render json: character
    end

    def create
        character = current_user.characters.build(character_params)

        if character.save
            render json: character, status: :created
        else
            render json: { errors: character.errors }, status: :unprocessable_entity
        end
    end

    def update
        if @character.update(character_params)
            render json: @character
        else
            render json: @character.errors, status: :unprocessable_entity
        end
    end
      
    def destroy
        @character.destroy
        head 204
    end
 
    private

    def check_owner
        head :forbidden unless @character.user_id == current_user&.id
    end

    def set_character
        @character = Character.find(params[:id])
    end

    def character_params
        params.require(:character).permit(:image, :name, :age, :weight, :history)
    end
end
