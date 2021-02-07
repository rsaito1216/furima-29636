class ItemsController < ApplicationController
  before_action :login_check, only: [:new]
  before_action :set_item, only: [:edit, :show, :update, :destroy]
  before_action :set_parents, only: [:new, :create ,:edit, :update]

  def index
    @items = Item.all

  end
  
  def new
    @item = Item.new

  end

  def create
    @item = Item.new(item_params)
    if @item.valid?
      @item.save
      redirect_to action: :index
    else
      render action: :new
    end
  end

  def show
    # @comment = Comment.new
    # @comments = @item.comments.includes(:user)
    @comments = @item.comments
    @comment = @item.comments.build #投稿全体へのコメント投稿用の変数
    @comment_reply = @item.comments.build

    @category_id = @item.category_id
    @category_parent = Category.find(@category_id).parent.parent
    @category_child = Category.find(@category_id).parent
    @category_grandchild = Category.find(@category_id)

    @category = Category.find(params[:id])
end

  def edit
     #カテゴリーデータ取得
  @grandchild_category = @item.category
  @child_category = @grandchild_category.parent 
  @category_parent = @child_category.parent

  #カテゴリー一覧を作成
  @category = Category.find(params[:id])
  # 紐づく孫カテゴリーの親（子カテゴリー）の一覧を配列で取得
  @category_children = @item.category.parent.parent.children
  # 紐づく孫カテゴリーの一覧を配列で取得
  @category_grandchildren = @item.category.parent.children
end

  def update
    #カテゴリーデータ取得
  @grandchild_category = @item.category
  @child_category = @grandchild_category.parent 
  @category_parent = @child_category.parent

  #カテゴリー一覧を作成
  @category = Category.find(params[:id])
  # 紐づく孫カテゴリーの親（子カテゴリー）の一覧を配列で取得
  @category_children = @item.category.parent.parent.children
  # 紐づく孫カテゴリーの一覧を配列で取得
  @category_grandchildren = @item.category.parent.children
  if params[:item][:image_ids]
    params[:item][:image_ids].each do |image_id|
      image = @item.images.find(image_id)
      image.purge
    end
    if params[:item][:image_ids].nil?
      render :edit
    end
  end
  

    if @item.update(item_params)
      
      redirect_to item_path(@item)
    else
      render action: :edit
    end
  end

  def destroy
    if @item.user_id == current_user.id
      @item.destroy
      redirect_to action: :index
    else
      render action: :show
    end
  end

  def search
    @items = Item.search(params[:keyword])
  end

  def get_category_children
    @category_children = Category.find("#{params[:parent_id]}").children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  private

  def item_params
    params.require(:item).permit(:product_name, :description, :category_id, :condition_id, :delivery_burden_id, :shipping_address_id, :shipping_day_id, :price, images: []).merge(user_id: current_user.id)
  end

  def login_check
    unless user_signed_in?
      flash[:alert] = "出品するにはログインか新規登録をしてください"
      redirect_to new_user_session_path
    end
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_parents
    @parents =  Category.where(ancestry: nil)
  end

  end
  
end
