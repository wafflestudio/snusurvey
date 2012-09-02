class Admin::FeedbacksController < Admin::AdminController
  def index
		@feedbacks = Feedback.all
  end

	def show
		@feedback = Feedback.find(params[:id])
	end

	def new
		@feedback = Feedback.new
	end

	def edit
		@feedback = Feedback.find(params[:id])
	end

	def create
		@feedback = Feedback.new(params[:feedback])
		if @feedback.save
			redirect_to admin_feedbacks_path
		else
			render new_admin_feedback_path
		end
	end

	def update
		@feedback = Feedback.find(params[:id])
		if @feedback.update_attributes(params[:feedback])
			redirect_to admin_feedback_path(@feedback)
		else
			render edit_admin_feedback_path
		end
	end

	def destroy
		@feedback = Feedback.find(params[:id])
		@feedback.destroy
		redirect_to admin_feedbacks_path
	end
end
