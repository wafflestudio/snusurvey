class Admin::QuestionsController < Admin::AdminController
  def index
		@questions = Question.all
  end

	def show
		@question = Question.find(params[:id])
	end

	def new
		@question = Question.new
	end

	def edit
		@question = Question.find(params[:id])
	end

	def create
		@question = Question.new(params[:question])
		if @question.save
			redirect_to admin_questions_path
		else
			render new_admin_question_path
		end
	end

	def update
		@question = Question.find(params[:id])
		if @question.update_attributes(params[:question])
			redirect_to admin_question_path(@question)
		else
			render edit_admin_question_path
		end
	end

	def destroy
		@question = Question.find(params[:id])
		@question.destroy
		redirect_to admin_questions_path
	end
end
