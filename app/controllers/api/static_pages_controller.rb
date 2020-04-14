class Api::StaticPagesController < Api::ApiController
  def home
    if logged_in?
      @feed_items = current_user.feed.page(params[:page]).per(params[:per])
      # render json: {
      #   feed_items: @feed_items
      # }
    end
  end
end
