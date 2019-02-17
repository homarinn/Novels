class NovelsController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :create, :edit, :update, :destroy]
  before_action :check_my_novel, only:  [:edit, :update, :destroy]
  
  def index
    query = { title_cont: params[:q] }
    search = Novel.ransack(query)
    @novels = search.result.page(params[:page])
  end
  
  
  def show
    @novel = Novel.find(params[:id])
    session[:novel_id] = @novel.id
  end

  def new
    @novel = Novel.new
  end

  def create
    @novel = current_user.novels.build(novel_params)
    if @novel.save
      flash[:success] = "小説を作成しました。"
      redirect_to @novel
    else
      flash[:danger] = "小説の作成に失敗しました。"
      render "new"
    end
  end

  def edit
    @novel = Novel.find(params[:id])
  end

  def update
    @novel = Novel.find(params[:id])
    
    if @novel.update(novel_params)
      flash[:success] = "小説を更新しました。"
      redirect_to @novel
    else
      flash[:danger] = "小説の更新に失敗しました。"
      render "edit"
    end
  end

  def destroy
    @novel = Novel.find(params[:id])
    @novel.destroy
    
    flash[:success] = "小説を削除しました。"
    redirect_to user_url(current_user)
  end
  
  private
  
  def novel_params
    params.require(:novel).permit(:title, :summary, :tag_list)
  end
  
  def check_my_novel
      @novel = Novel.find(params[:id])
      if @novel.user != current_user
        flash[:danger] = "編集の権限がありません。"
        redirect_to root_url
      end
  end
end
