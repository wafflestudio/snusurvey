class Admin::CategoriesController < Admin::AdminController
  def index
		@categories = Category.all
  end

	def show
		@category = Category.find(params[:id])
	end

	def new
		@category = Category.new
	end

	def edit
		@category = Category.find(params[:id])
	end

	def create
		@category = Category.new(params[:category])
		if @category.save
			redirect_to admin_categories_path
		else
			render new_admin_category_path
		end
	end

	def update
		@category = Category.find(params[:id])
		if @category.update_attributes(params[:category])
			redirect_to admin_category_path(@category)
		else
			render edit_admin_category_path
		end
	end

	def destroy
		@category = Category.find(params[:id])
		@category.destroy
		redirect_to admin_categories_path
	end
end
