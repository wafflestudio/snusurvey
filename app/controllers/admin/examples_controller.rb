class Admin::ExamplesController < Admin::AdminController
  def index
		@examples = Example.all
  end

	def show
		@example = Example.find(params[:id])
	end

	def new
		@example = Example.new
	end

	def edit
		@example = Example.find(params[:id])
	end

	def create
		@example = Example.new(params[:example])
		if @example.save
			redirect_to admin_examples_path
		else
			render new_admin_example_path
		end
	end

	def update
		@example = Example.find(params[:id])
		if @example.update_attributes(params[:example])
			redirect_to admin_example_path(@example)
		else
			render edit_admin_example_path
		end
	end

	def destroy
		@example = Example.find(params[:id])
		@example.destroy
		redirect_to admin_examples_path
	end
end
