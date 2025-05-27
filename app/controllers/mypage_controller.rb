class MypageController < ApplicationController
  before_action :authenticate_user!
  def index
    if params[:title].present?
      @articles = current_user.articles.where("title LIKE ?", "%#{params[:title]}%").page(params[:page]).per(5)
    else
      @articles = current_user.articles.page(params[:page]).per(5)
    end
  end
end
