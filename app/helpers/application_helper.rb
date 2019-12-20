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
end
