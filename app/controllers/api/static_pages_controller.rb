class Api::StaticPagesController < Api::ApiController
  def home
    if logged_in?
      @feed_items = current_user.feed.page(params[:page]).per(params[:per])
    else
      head :ok
    end
  end
end
