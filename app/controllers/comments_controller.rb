class CommentsController < ApplicationController
  def create
    comment = Comment.create(comment_params)
    if comment.save
      ActionCable.server.broadcast 'comment_channel', content: comment, user: comment.user
    end
  end

  def destroy
    comment = Comment.find_by(item_id: params[:item_id],id: params[:id])
    comment.destroy
    redirect_to "/items/#{comment.item.id}"
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
