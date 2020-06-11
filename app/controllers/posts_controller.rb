class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    @bloggers = Blogger.all
    @destinations = Destination.all
  end

  def create
    post = Post.create(post_params)
    if post.valid?
      redirect_to destination_path(post.destination_id)
    else
      flash[:post_errors] = post.errors.full_messages
      redirect_to new_post_path
    end
  end

  def edit
    @post = Post.find(params[:id])
    @bloggers = Blogger.all
    @destinations = Destination.all
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path
  end

  def like
    @post = Post.find(params[:id])
    @post.increase_likes
    @post.save
    redirect_to post_path(@post)
  end

  private

  def post_params
    params.require(:post).permit!
  end

end
