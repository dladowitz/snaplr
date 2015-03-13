class FollowingsController < ApplicationController
  def create
    followed = User.find params[:user_id]
    follower = User.find session[:id]

    unless Followings.create user_id: followed.id, follower_id: follower.id
      flash[:danger] = "Couldn't follow user for some reason"
    end

    redirect_to user_posts_path(followed)
  end

  def destroy
    @following = Followings.find params[:id]

    @following_user = User.find params[:user_id]
    @following.delete

    redirect_to user_posts_path(@following_user)
  end

  private

  def followings_params
    params.require(:following).permit(:follower_id, :user_id, :id)
  end
end
