class ArticlesController < ApplicationController
  include ApplicationHelper
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 6).order('id DESC')
  end

  def show
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { redirect_to @article, alert: 'Article was not created.'}
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def like_article
    unless current_user
      flash[:alert] = "Please login to like article"
    end
    article = Article.find(params[:format].to_i)
    liked_article = i_have_liked_article article.id
    
    if liked_article
      liked_article.destroy
    else
      Like.create(article:article, user:current_user)
    end
    redirect_to articles_url
  end

  def bookmark_article
    unless current_user
      flash[:alert] = "Please login to bookmark article"
    end
    article = Article.find(params[:format].to_i)
    bookmarked_article = i_have_bookmarked_article article.id
    
    if bookmarked_article
      bookmarked_article.destroy
    else
      Bookmark.create(article:article, user:current_user)
    end
    redirect_to bookmarks_url
  end

  def get_bookmarks
    @bookmarks = Bookmark.where(user:current_user)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :body)
    end
end
