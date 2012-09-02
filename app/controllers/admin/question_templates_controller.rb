class Admin::QuestionTemplatesController < Admin::AdminController
  def index
		@question_templates = QuestionTemplate.all
  end

	def show
		@question_template = QuestionTemplate.find(params[:id])
	end

	def new
		@question_template = QuestionTemplate.new
	end

	def edit
		@question_template = QuestionTemplate.find(params[:id])
	end

	def create
		@question_template = QuestionTemplate.new(params[:question_template])
		if @question_template.save
			redirect_to admin_question_templates_path
		else
			render new_admin_question_template_path
		end
	end

	def update
		@question_template = QuestionTemplate.find(params[:id])
		if @question_template.update_attributes(params[:question_template])
			redirect_to admin_question_template_path(@question_template)
		else
			render edit_admin_question_template_path
		end
	end

	def destroy
		@question_template = QuestionTemplate.find(params[:id])
		@question_template.destroy
		redirect_to admin_question_templates_path
	end
end
