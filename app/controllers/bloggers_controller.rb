class BloggersController < ApplicationController

  def index
    @bloggers = Blogger.all
  end

  def show
    @blogger = Blogger.find(params[:id])
    @posts = Post.all.select {|p| p.blogger == @blogger}
    @likes = @posts.map {|p| p.likes}
    # @t_post = top_post(@posts)
    likes_count = {}
    @posts.each do |p|
      likes_count[p] = p.likes
    end
    @t_post = likes_count.max_by{|k, v| v}[0]
    # byebug
  end

  # def top_post(posts)
  #   likes_count = {}
  #   posts.each do |p|
  #     likes_count[p] = p.likes
  #   end
  #   likes_count.max_by{|k, v| v}
  # end

  def new
    @blogger = Blogger.new
  end

  def create
    blogger = Blogger.create(blogger_params)
    if blogger.valid?
      redirect_to blogger_path(blogger)
    else
      flash[:blogger_errors] = blogger.errors.full_messages
      redirect_to new_blogger_path
    end
  end

  private

  def blogger_params
    params.require(:blogger).permit(:name, :bio, :age)
  end

end
