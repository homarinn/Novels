class StoriesController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :create, :edit, :update, :destroy]
  before_action :check_my_novel, only:  [:new, :create, :edit, :update, :destroy]
  def show
    @story = Story.find(params[:id])
  end
  
  def new
    @novel = Novel.find(session[:novel_id])
    @story = @novel.stories.build
  end

  def create
    @novel = Novel.find(session[:novel_id])
    @story = @novel.stories.build(story_params)
    
    if @story.save
      flash[:success] = "話を投稿しました。"
      session[:novel_id] = nil
      redirect_to novel_path(id: @story.novel_id)
    else
      flash[:danger] = "話の投稿に失敗しました。"
      render "new"
    end
  end

  def edit
    @story = Story.find(params[:id])
  end

  def update
    @story = Story.find(params[:id])
    
    if @story.update(story_params)
      flash[:success] = "話を編集しました。"
      redirect_to @story
    else
      flash[:danger] = "話の編集に失敗しました。"
      render "edit"
    end
  end

  def destroy
    @story = Story.find(params[:id])
    session[:destroy] = @story.novel_id
    @story.destroy
    flash[:success] = "話を削除しました。"
    redirect_to novel_url(id: session[:destroy])
    session[:destroy] = nil
    
  end
  
  private
  
  def story_params
    params.require(:story).permit(:subtitle, :content)
  end
  
  def check_my_novel
      @novel = Novel.find(session[:novel_id])
      if @novel.user != current_user
        redirect_to root_url
      end
  end

end
