class CommentsController < ApplicationController
    def create_comment
        @comment = Comment.new(comment_params)
        @comment.user_id = current_user.id
    
        respond_to do |format|
          if @comment.save
            format.html { redirect_to :controller => 'articles', :action => 'show', notice: 'You successfully commented.' }
            # format.json { render :show, status: :created, location: @article }
          else
            format.html { render :new }
            format.json { render json: @article.errors, status: :unprocessable_entity }
          end
        end        
    end

    private

    def comment_params
      params.permit(:body,:article_id)
    end
  end