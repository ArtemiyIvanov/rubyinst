module UsersHelper
    def user_avatar(user, height)
        image_path = user.avatar.attached? ? url_for(user.avatar) : "avatar_placeholder.png" 
        image_tag(image_path, :width => 'auto', :height => height.to_s, :class => 'rounded-3')
    end

    def same_user?(user_id)
        current_user.id == user_id
    end

    def followed?(user_id)
        Follower.where(follower_id: current_user.id, following_id: user_id).any?
    end
end
