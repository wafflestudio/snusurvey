class Admin::UsersController < Admin::AdminController
  def index
		@users = User.all
  end

	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end

	def edit
		@user = User.find(params[:id])
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			redirect_to admin_users_path
		else
			render new_admin_user_path
		end
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(params[:user])
			redirect_to admin_user_path(@user)
		else
			render edit_admin_user_path
		end
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
		redirect_to admin_users_path
	end
end
