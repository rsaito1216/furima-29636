class CommentsController < ApplicationController
  def create
    @item = Item.find(params[:item_id])
      # @comment = Comment.create(comment_params)
      @comment = current_user.comments.build(comment_params)

    if @comment.valid?
      @comment.save
      # CommentChannel.broadcast_to @item, {content: @comment, user: @comment.user, time: @comment.created_at.strftime("%Y/%m/%d %H:%M:%S")}
      redirect_to "/items/#{@comment.item.id}"
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
    params.require(:comment).permit(:text, :reply, :parent_id).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
