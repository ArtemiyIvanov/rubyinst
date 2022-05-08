class PostsController < ApplicationController
    def index
        if current_user
            @posts = Post.order(created_at: :desc).page(params[:page]).per(5)
        else
            redirect_to home_index_path
        end
    end

    def feed
        if current_user
            following = Follower.where(follower_id: current_user.id)
            ids = []
            following.each do |follow| 
                ids.push(follow.following_id)
            end
            @feed_posts = Post.where(user_id: ids).order(created_at: :desc).page(params[:page]).per(5)
        else
            redirect_to home_index_path
        end
    end

    def show
        if current_user
            @post = Post.find(params[:id])
            post_id = 'post_id = ' + params[:id].to_s
            @comments = Comment.where(post_id: params[:id])
        else
            redirect_to home_index_path
        end
    end
    
    def new
        if current_user
            @post = Post.new
        else
            redirect_to home_index_path
        end
    end
    def create
        if current_user
            @post = Post.new(post_params)

            if @post.save
                redirect_to @post
            else
                render :new, status: :unprocessable_entity
            end
        else
            redirect_to home_index_path
        end
    end

    def edit
        if current_user
            @post = Post.find(params[:id])
        else
            redirect_to home_index_path
        end
    end

    def update
        if current_user
            @post = Post.find(params[:id])
    
            if @post.update(post_params)
                redirect_to @post
            else
                render :edit, status: :unprocessable_entity
            end
        else
            redirect_to home_index_path
        end
    end

    def destroy
        if current_user
            @post = Post.find(params[:id])
            if @post.destroy
                redirect_to user_path(current_user), status: :see_other
            end
        else
            redirect_to home_index_path
        end
    end

    def like
        if current_user
            @post = Post.find(params[:post_id])
            if Like.create(user_id: current_user.id, post_id: params[:post_id])
                redirect_to @post
            end
        else
            redirect_to home_index_path
        end
    end

    def unlike

        if current_user
            @post = Post.find(params[:post_id])
            like = Like.where(user_id: current_user.id, post_id: params[:post_id])
            if like.first.destroy
                redirect_to @post
            end
        else
            redirect_to home_index_path
        end
        
    end

    private
    def post_params
        params.require(:post).permit(:description, :image, :user_id)
    end
end
