module PostsHelper
    def can_edit?(user_id)
        current_user.id == user_id
    end

    def same_user?(user_id)
        current_user.id == user_id
    end

    def liked?(post)
        Like.where(user_id: current_user.id, post_id: post.id).any?
    end
end
