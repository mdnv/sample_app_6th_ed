class Api::SessionsController < Api::ApiController
  def index
    render json: { user: current_user } if current_user
  end
  def destroy
    log_out if logged_in?
  end
end
