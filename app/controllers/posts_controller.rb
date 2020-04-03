class PostsController < ApplicationController
  before_action :authenticate_user!
  layout 'account'
  def index
    @post = Post.new
    timeline_posts
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to posts_path, notice: 'Post was successfully created.'
    else
      timeline_posts
      render :index, alert: 'Post was not created.'
    end
  end

  private

  def timeline_posts
    # @timeline_posts ||= Post.all.ordered_by_most_recent.includes(:user)

    friends_posts = current_user.friends.map(&:id)
    friends_posts.join(',')

    @timeline_posts ||= Post.where('user_id IN (:friends_posts) OR user_id = :user_id', friends_posts: friends_posts, user_id: current_user.id).ordered_by_most_recent.to_a
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
