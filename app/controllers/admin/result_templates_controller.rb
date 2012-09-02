class Admin::ResultTemplatesController < Admin::AdminController
  def index
		@result_templates = ResultTemplate.all
  end

	def show
		@result_template = ResultTemplate.find(params[:id])
	end

	def new
		@result_template = ResultTemplate.new
	end

	def edit
		@result_template = ResultTemplate.find(params[:id])
	end

	def create
		@result_template = ResultTemplate.new(params[:result_template])
		if @result_template.save
			redirect_to admin_result_templates_path
		else
			render new_admin_result_template_path
		end
	end

	def update
		@result_template = ResultTemplate.find(params[:id])
		if @result_template.update_attributes(params[:result_template])
			redirect_to admin_result_template_path(@result_template)
		else
			render edit_admin_result_template_path
		end
	end

	def destroy
		@result_template = ResultTemplate.find(params[:id])
		@result_template.destroy
		redirect_to admin_result_templates_path
	end
end
