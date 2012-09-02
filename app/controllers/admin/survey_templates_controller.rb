class Admin::SurveyTemplatesController < Admin::AdminController
  def index
		@survey_templates = SurveyTemplate.all
  end

	def show
		@survey_template = SurveyTemplate.find(params[:id])
	end

	def new
		@survey_template = SurveyTemplate.new
	end

	def edit
		@survey_template = SurveyTemplate.find(params[:id])
	end

	def create
		@survey_template = SurveyTemplate.new(params[:survey_template])
		if @survey_template.save
			redirect_to admin_survey_templates_path
		else
			render new_admin_survey_template_path
		end
	end

	def update
		@survey_template = SurveyTemplate.find(params[:id])
		if @survey_template.update_attributes(params[:survey_template])
			redirect_to admin_survey_template_path(@survey_template)
		else
			render edit_admin_survey_template_path
		end
	end

	def destroy
		@survey_template = SurveyTemplate.find(params[:id])
		@survey_template.destroy
		redirect_to admin_survey_templates_path
	end
end
