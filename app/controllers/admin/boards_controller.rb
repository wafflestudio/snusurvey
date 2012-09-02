class Admin::BoardsController < Admin::AdminController
  def index
		@boards = Board.all
  end

	def show
		@board = Board.find(params[:id])
	end

	def new
		@board = Board.new
	end

	def edit
		@board = Board.find(params[:id])
	end

	def create
		@board = Board.new(params[:board])
		if @board.save
			redirect_to admin_boards_path
		else
			render new_admin_board_path
		end
	end

	def update
		@board = Board.find(params[:id])
		if @board.update_attributes(params[:board])
			redirect_to admin_board_path(@board)
		else
			render edit_admin_board_path
		end
	end

	def destroy
		@board = Board.find(params[:id])
		@board.destroy
		redirect_to admin_boards_path
	end
end
