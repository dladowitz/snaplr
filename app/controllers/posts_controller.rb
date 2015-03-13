class PostsController < ApplicationController
  def index
    @current_user = User.find session[:id]
    @user = User.find_by_id params[:user_id]
    @page_name = "Here is what #{@user.first_name} is saying"

    @posts = @user.posts.sort_by{|post| post.created_at}.reverse

    get_followings
  end

  def new
    @page_name = "Post Something New"
    @post = Post.new
  end

  def create
    @user = User.find session[:id]
    @post = @user.posts.build post_params

    if @post.save
      redirect_to user_posts_path(@user)
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end

  def get_followings
    if @current_user.following.include?(@user)
      @following = current_user.following_relations.where(user_id: @user.id).first
    else
      @following = false
    end
  end
end
