class Api::UsersController < Api::ApiController
  before_action :logged_in_user, only: [:index, :destroy]
  before_action :admin_user,     only: :destroy
  def index
    @users = User.page(params[:page])
  end
  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      render json: {
        flash: ["info", "Please check your email to activate your account."],
        user: @user
        # redirect_to root_url
      }
    else
      render json: { error: @user.errors.full_messages }
    end
  end
  def destroy
    User.find(params[:id]).destroy
    render json: { flash: ["success", "User deleted"] }
  end
  private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
    # Before filters
    # Confirms an admin user.
    def admin_user
      unless current_user.admin?
        render json: { flash: ["info", "Current User aren't admin"] }
      end
    end
end
