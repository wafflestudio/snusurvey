class Admin::RepliesController < Admin::AdminController
  def index
		@replies = Reply.all
  end

	def show
		@reply = Reply.find(params[:id])
	end

	def new
		@reply = Reply.new
	end

	def edit
		@reply = Reply.find(params[:id])
	end

	def create
		@reply = Reply.new(params[:reply])
		if @reply.save
			redirect_to admin_replies_path
		else
			render new_admin_reply_path
		end
	end

	def update
		@reply = Reply.find(params[:id])
		if @reply.update_attributes(params[:reply])
			redirect_to admin_reply_path(@reply)
		else
			render edit_admin_reply_path
		end
	end

	def destroy
		@reply = Reply.find(params[:id])
		@reply.destroy
		redirect_to admin_replies_path
	end
end
