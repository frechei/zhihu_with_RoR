class CommentsController < ApplicationController
	before_action :logged_in_user, only: [:create]

	def create
		@commentable = find_commentable
		@comment = @commentable.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
    	respond_to do |format|
        format.html { redirect_to @commentable }
        format.js
      end
    end
	end

	private 
		def find_commentable   
		  params.each do |name, value|   
		    if name =~ /(.+)_id$/   
		      return $1.classify.constantize.find(value)   
		    end  
		  end  
		  nil  
		end

		def comment_params
			params.require(:comment).permit(:text)
		end

		def logged_in_user
      unless logged_in?
        flash[:info] = "请先登陆"
        redirect_to login_url
      end
    end
end
