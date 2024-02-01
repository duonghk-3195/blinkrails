class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @post = current_user.posts.build
      @feed_items = current_user.feed.paginate page: params[:page], per_page:2
    end
  end

  def help
  end
end
