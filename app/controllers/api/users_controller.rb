class Api::UsersController < Api::ApiController
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

  private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
