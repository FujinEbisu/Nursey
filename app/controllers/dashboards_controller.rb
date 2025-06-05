class DashboardsController < ApplicationController
    before_action :mother, :doctor, :user, only: [:index]

    def index
        
    end

private

    def mother
        @mother = current_user.userable
    end

    def feeds
    end

    def doctor
        @doctor = current_user.userable
    end

    def user
        @user = current_user
    end

    def mother_params
        params.require(:mother).permit(:first_name, :last_name, :email, :password, :password_confirmation) 
    end

    def doctor_params
        params.require(:doctor).permit(:first_name, :last_name, :email, :password, :password_confirmation) 
    end

    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation) 
    end

end
