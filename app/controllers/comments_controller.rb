class CommentsController < ApplicationController
  def create
    # @item = Item.find(id: params[:item_id])
      @comment = Comment.create(comment_params)
    if @comment.valid?
      @comment.save
      # ActionCable.server.broadcast 'comment_channel', content: comment, user: comment.user, time: comment.created_at.strftime("%Y/%m/%d %H:%M:%S")
      CommentChannel.broadcast_to @item, {content: @comment, user: @comment.user, time: @comment.created_at.strftime("%Y/%m/%d %H:%M:%S")}
    else
      render action: :show
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
