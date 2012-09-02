class Admin::PapersController < Admin::AdminController
  def index
		@papers = Paper.all
  end

	def show
		@paper = Paper.find(params[:id])
	end

	def new
		@paper = Paper.new
	end

	def edit
		@paper = Paper.find(params[:id])
	end

	def create
		@paper = Paper.new(params[:paper])
		if @paper.save
			redirect_to admin_papers_path
		else
			render new_admin_paper_path
		end
	end

	def update
		@paper = Paper.find(params[:id])
		if @paper.update_attributes(params[:paper])
			redirect_to admin_paper_path(@paper)
		else
			render edit_admin_paper_path
		end
	end

	def destroy
		@paper = Paper.find(params[:id])
		@paper.destroy
		redirect_to admin_papers_path
	end
end
