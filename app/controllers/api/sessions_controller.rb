class Api::SessionsController < Api::ApiController
  def index
    render json: { user: current_user } if current_user
  end
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        render json: { user: user }
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        render json: { flash: ["warning", message] }
      end
    else
      render json: { flash: ["danger", "Invalid email/password combination"] }
    end
  end
  def destroy
    log_out if logged_in?
  end
end
