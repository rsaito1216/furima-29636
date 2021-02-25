class CommentsController < ApplicationController
  def create
    @item = Item.find(params[:item_id])
      # @comment = Comment.create(comment_params)
    
    @comment = current_user.comments.build(comment_params)

    @comment.save
    redirect_to "/items/#{@comment.item.id}"
    
    if @comment.text.present? && @comment.parent_id.nil?
      CommentChannel.broadcast_to @item, {content: @comment, user: @comment.user, time: @comment.created_at.strftime("%Y/%m/%d %H:%M:%S"), parent_id: @comment.parent_id,}
    end
    
    if @comment.text.present? && @comment.parent_id.present?
      ReplyChannel.broadcast_to @item, {content: @comment, user: @comment.user, time: @comment.created_at.strftime("%Y/%m/%d %H:%M:%S"), parent_id: @comment.parent_id,}
    end
    
  end

  def destroy
    comment = Comment.find_by(item_id: params[:item_id],id: params[:id])
    comment.destroy
    redirect_to "/items/#{comment.item.id}"
  end

  private
  def comment_params
    params.require(:comment).permit(:text, :reply, :parent_id).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
