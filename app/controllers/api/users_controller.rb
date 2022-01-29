class Api::UsersController < ApplicationController

    def create
        @user = User.new(user_params)
        if @user.save
            UserNotifierMailer.send_signup_email(@user).deliver
            render json: @user, status: :created
        else
            render json: @user.errors, status: :unprocessable_entity
        end
    end

    private
    # Only allow a trusted parameter "white list" through.
        
    def user_params
        params.require(:user).permit(:name, :email, :password)
    end
      
    
      
end
