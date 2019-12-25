module ApplicationHelper
    def resource_name
        :user
    end

    def resource
        @user ||= User.new
    end

    def devise_mapping
        @devise_mapping ||= Devise.mappings[:user]
    end

    def user_name
        current_user.email.rpartition('@').first
    end

    def article_owner article
        true if current_user.id == article.user_id
    end

    def i_have_liked_article article_id
        Like.find_by(user:current_user, article_id:article_id)
    end

    def i_have_bookmarked_article article_id
        Bookmark.find_by(user:current_user, article_id:article_id)
    end
end
