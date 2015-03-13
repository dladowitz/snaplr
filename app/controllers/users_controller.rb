class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @page_name = "Find someone new to follow"
    @users = User.all
  end

  def new
    @user = User.new

    render layout: "landing_page/landing_layout"
  end

  def create
    @user = User.new user_params

    if @user.save
      flash[:success] = "User account created successfully"
      redirect_to signin_path
    else
      render :new
    end
  end

  def show
    @page_name = "Dashboard"

    if @user

      get_followed_users_posts

      render :show
    else
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def get_followed_users_posts
    if @user.following.present?

      # I'd do pagination here so the controller doesn't blow up
      @followed_users_posts = @user.following.map {|followed| followed.posts }
      @followed_users_posts.flatten!.sort_by! {|post| post.created_at}
      @followed_users_posts.reverse!
    end
  end
end
