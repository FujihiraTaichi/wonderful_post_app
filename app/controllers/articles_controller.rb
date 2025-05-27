class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  # GET /articles or /articles.json
  def index
    if params[:title].present?
      @articles = Article.where("title LIKE ?", "%#{params[:title]}%").page(params[:page]).per(5)
    else
      @articles = Article.page(params[:page]).per(5)
    end
  end

  # GET /articles/1 or /articles/1.json
  def show
    @article = Article.find(params[:id])
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
    @article =
    current_user.articles.find(params[:id])
  end


  # POST /articles or /articles.json
  def create
    @article =
    current_user.articles.build(article_params)
    respond_to do |format|
      if @article.save
        flash[:notice] = t('flash.notice')
        format.html { redirect_to @article, notice: "Article was successfully created." }
      else
        flash[:alert] = t('flash.alert')
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: "Article was successfully updated." }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article =
    current_user.articles.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_path, status: :see_other, notice: "Article was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :content, tag_ids: [])
   end


    def correct_user
      @article = Article.find(params[:id])
      redirect_to articles_path, alert: '権限がありません。' unless @article.user == current_user
    end
end
