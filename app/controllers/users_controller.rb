class UsersController < ApplicationController
    before_action :authenticate_user!

    def show
        @user  = User.find(params[:id])
        @posts = @user.posts.order(created_at: :desc)
    end


    def update
        @user = User.find(params[:id])

        if @user.update(user_params)
          redirect_to @user
        else
          render :edit, status: :unprocessable_entity
        end
    end

    def follow
        @user = User.find(params[:follow_id])
        user_id = params[:follow_id]
        Follower.create(follower_id: current_user.id, following_id: user_id)
        redirect_to @user
    end

    def unfollow
      @user = User.find(params[:follow_id])
      user_id = params[:follow_id]
      follow = Follower.where(follower_id: current_user.id, following_id: user_id)
      follow.first.destroy
      redirect_to @user
    end

    def show_followers
      @user  = User.find(params[:id])
      followers = @user.followers
      ids = []
      followers.each do |follow| 
        ids.push(follow.follower_id)
      end
      @followers = User.where(id: ids).order(created_at: :desc).page(params[:page]).per(5)
    end

    def show_following
      @user  = User.find(params[:id])
      following = @user.following
      ids = []
      following.each do |follow| 
        ids.push(follow.following_id)
      end
      @following = User.where(id: ids).order(created_at: :desc).page(params[:page]).per(5)
    end

    def search
      
        @users = User.where("username LIKE ?", "%" + params[:query] + "%").page(params[:page]).per(5)
    end

    private
    def user_params
      params.require(:user).permit(:username, :first_name, :last_name,
        :bio, :gender, :avatar)
    end

end
