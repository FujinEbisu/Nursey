class DashboardsController < ApplicationController
    before_action :mother, :doctor, :user, :feeds, :moods, only: [:index]

    def index
        
        feed_count
    end

private

    def feed_count
        @Tirage_count = 0
        @Tetee_count = 0
        @Feeds_count = 0
        @Feeds.each do |feed|
            if feed.nursy_type == "Tirage"
                @Tirage_count += 1
            else
                @Tetee_count += 1
            end
        end
        @Feeds_count = @Tirage_count + @Tetee_count
    end

    def mother
        @mother = current_user.userable
    end

    def feeds
        @Feeds = Feed.where(mother_id: @mother.id)
    end

    def moods
        @Moods = Feed.where(mother_id: @mother.id).pluck(:mood)
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
