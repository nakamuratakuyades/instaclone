class BlogsController < ApplicationController
  before_action :authenticate_user,{only:[:new, :edit, :update, :destroy, :show]}

  def index
    @blogs = Blog.all.order(created_at: :desc)
    @user = User.all
  end

  def new
    if @current_user == nil
      flash[:notice]="ログインが必要です"
      redirect_to("/login")
    end

    if params[:back]
      @blog = Blog.new(blog_params)
    else
      @blog = Blog.new
    end
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    @user = @blog.user
    if @blog.save
      #SampleMailer.send_when_create(@user).deliver
      redirect_to blogs_path, notice: "ブログを作成しました！"
    else
      # 入力フォームを再描画します。
      render 'new'
    end
  end

  def confirm
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id

    render :new if @blog.invalid?
  end

  def show
    @blog = Blog.find(params[:id])
    @user = @blog.user
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def update
    @blog = Blog.find(params[:id])
    if @blog.update(blog_params)
      redirect_to blogs_path(params[:id]), notice: "ブログを編集しました！"
    else
      render 'edit'
    end
  end

  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to blogs_path, notice:"ブログを削除しました！"
  end

  def contact

  end

  private

  def blog_params
    params.require(:blog).permit(:title, :content, :image, :image_cache)
  end

  def set_blog
    @blog = Blog.find params[:id]
  end

end
