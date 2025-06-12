class DashboardsController < ApplicationController
    before_action :mother, :doctor, :user, :feeds, :moods, only: [:index]

    def index
        feed_count

        feeds_last_week     = @Feeds.where(created_at: 7.days.ago..Time.current)

        # 1. Feeds per day split by type (last 7 days)
        days                = (0..6).map { |i| i.days.ago.to_date }.reverse
        @tetee_per_day      = days.map { |d| feeds_last_week.where(nursy_type: "Tetee",  created_at: d.all_day).count }
        @tirage_per_day     = days.map { |d| feeds_last_week.where(nursy_type: "Tirage", created_at: d.all_day).count }
        @day_labels         = days.map { |d| d.strftime("%d/%m") }

        # 2. Quantity pumped per day (Tirage only)
        @quantity_per_day   = days.map do |d|
            feeds_last_week.where(nursy_type: "Tirage", created_at: d.all_day)
                           .sum("COALESCE(quantity_left,0) + COALESCE(quantity_right,0)")
        end

        # 3. Average duration per day (Tetee only, minutes)
        @duration_per_day   = days.map do |d|
            left  = feeds_last_week.where(nursy_type: "Tetee", created_at: d.all_day).average(:time_left)
            right = feeds_last_week.where(nursy_type: "Tetee", created_at: d.all_day).average(:time_right)
            avg_seconds = ([left,0].max + [right,0].max) / 2 rescue 0
            (avg_seconds / 60).round(1)
        end

        # 4. Real interval vs target (hours between consecutive feeds)
        consecutive_pairs = @Feeds.order(:created_at).each_cons(2).to_a
        @intervals = consecutive_pairs.map { |prev,cur| ((cur.created_at - prev.created_at)/3600).round(2) }
        @interval_labels = @intervals.each_index.map { |i| "Feed #{i+1}" }
        @target_interval = @mother.time_between_feed
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
