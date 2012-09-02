class Admin::SurveysController < Admin::AdminController
  def index
		@surveys = Survey.all
  end

	def show
		@survey = Survey.find(params[:id])
	end

	def new
		@survey = Survey.new
	end

	def edit
		@survey = Survey.find(params[:id])
	end

	def create
		@survey = Survey.new(params[:survey])
		if @survey.save
			redirect_to admin_surveys_path
		else
			render new_admin_survey_path
		end
	end

	def update
		@survey = Survey.find(params[:id])
		if @survey.update_attributes(params[:survey])
			redirect_to admin_survey_path(@survey)
		else
			render edit_admin_survey_path
		end
	end

	def destroy
		@survey = Survey.find(params[:id])
		@survey.destroy
		redirect_to admin_surveys_path
	end
end
