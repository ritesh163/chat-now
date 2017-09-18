class RegistrationsController < Devise::RegistrationsController
	def new
    super
  end
  
  def create
  	@user = User.new(user_params)
  	if @user.save
      UserMailer.registration_confirmation(@user).deliver
      flash[:success] = "Please confirm your email address to continue"
      redirect_to root_url
    else
      flash[:error] = "Ooooppss, something went wrong!"
      render 'new'
    end  
  end

  def update
    super
  end

  private

  def user_params
  	params.require(:user).permit(:name,:email, :password,:password_confirmation,:p_no)
  end
end
