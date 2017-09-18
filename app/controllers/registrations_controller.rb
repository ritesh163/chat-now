class RegistrationsController < Devise::RegistrationsController
	def new
    super
  end

  def create
  	@user = User.new(user_params)
  	@user.save!
  	redirect_to root_path   
  end

  def update
    super
  end

  private

  def user_params
  	params.require(:user).permit(:name,:email, :password,:password_confirmation,:p_no)
  end
end
