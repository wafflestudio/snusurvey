class Admin::ExampleTemplatesController < Admin::AdminController
  def index
		@example_templates = ExampleTemplate.all
  end

	def show
		@example_template = ExampleTemplate.find(params[:id])
	end

	def new
		@example_template = ExampleTemplate.new
	end

	def edit
		@example_template = ExampleTemplate.find(params[:id])
	end

	def create
		@example_template = ExampleTemplate.new(params[:example_template])
		if @example_template.save
			redirect_to admin_example_templates_path
		else
			render new_admin_example_template_path
		end
	end

	def update
		@example_template = ExampleTemplate.find(params[:id])
		if @example_template.update_attributes(params[:example_template])
			redirect_to admin_example_template_path(@example_template)
		else
			render edit_admin_example_template_path
		end
	end

	def destroy
		@example_template = ExampleTemplate.find(params[:id])
		@example_template.destroy
		redirect_to admin_example_templates_path
	end
end
