class ItemsController < ApplicationController
  before_action :login_check, only: [:new]
  before_action :set_item, only: [:edit, :show, :update, :destroy]
  before_action :set_parents, only: [:index, :show, :new, :create ,:edit, :update, :search]
  before_action :search_item, only: [:index, :search]
  
  helper_method :sort_column, :sort_direction

  PER = 20

  def index
    @items = Item.all.page(params[:page]).per(PER)
    

    @items_sort = Item.order("#{sort_column} #{sort_direction}")
    @param = request.query_string
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
   end
   
   def sort_column
    Item.column_names.include?(params[:sort]) ? params[:sort] : 'created_at'
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
  @category_id = @item.category_id
  

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
  @category_id = @item.category_id
  

  #カテゴリー一覧を作成
  @category = Category.find(params[:id])
  # 紐づく孫カテゴリーの親（子カテゴリー）の一覧を配列で取得
  @category_children = @item.category.parent.parent.children
  # 紐づく孫カテゴリーの一覧を配列で取得
  @category_grandchildren = @item.category.parent.children
  
  
  
  #  if params[:item][:image_ids]
  #     params[:item][:image_ids].each do |image_id|
  #       image = @item.images.find(image_id)
  #       image.purge
  #     end
  #     if params[:item][:image_ids].nil?
  #       render :edit
  #     end
  #   end
    # if @item.update(item_params)
      
    #   redirect_to item_path(@item)
    # else
    #   render action: :edit
    # end

  @item.images.detach #一旦、すべてのimageの紐つけを解除
  if @item.update(item_params)
    redirect_to @item, notice: 'Item was successfully updated.'
  else
    render :edit
  end
end

def upload_image
  @image_blob = create_blob(params[:image])
  respond_to do |format|
    format.json { @image_blob.id }
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
    # @items = Item.search(params[:keyword])

    # search_params
    # @p = Item.ransack(params[:q])  # 検索オブジェクトを生成
    # @results = @p.result.includes(:category).page(params[:page]).per(params[:display_number])  # 検索条件にマッチした商品の情報を取得

    if params[:q].present?
    
      # params[:q]['product_name_cont_any'] = params[:q]['product_name_cont_any']
      # params[:q]['description_cont_any'] = params[:q]['description_cont_any']
      # params[:q]['product_name_cont_any'] = params[:q]['product_name_cont_any'].split(/[\p{blank}\s]+/)
      # params[:q]['description_cont_any'] = params[:q]['description_cont_any'].split(/[\p{blank}\s]+/)
      search_params
    @p = Item.with_keywords(params.dig(:q, :name_keywords)).with_description_keywords(params.dig(:q, :description_keywords)).ransack(params[:q])  # 検索オブジェクトを生成
    @results = @p.result.includes(:category).page(params[:page]).per(params[:display_number])  # 検索条件にマッチした商品の情報を取得
    # @results = @p.result.includes(:category).page(params[:page]).per(PER)  # 検索条件にマッチした商品の情報を取得

      
    else

          # 検索フォーム以外からアクセスした時の処理
      search_params
      @p = Item.with_keywords(params.dig(:q, :name_keywords)).with_description_keywords(params.dig(:q, :description_keywords)).ransack(params[:q])  # 検索オブジェクトを生成
      @results = @p.result.includes(:category).page(params[:page]).per(params[:display_number])  # 検索条件にマッチした商品の情報を取得
      # @results = @p.result.includes(:category).page(params[:page]).per(PER)  # 検索条件にマッチした商品の情報を取得

    end
      

    # @results = @p.result.includes(:category).page(params[:page]).per(params[:display_number])   # 検索条件にマッチした商品の情報を取得

    @results_all = @p.result.includes(:category)

    set_category_column

    # favorites = Item.includes(:favorite_users).sort {|a,b| b.favorite_users.size <=> a.favorite_users.size}


  
  

  
  
  end

  def get_category_children
    @category_children = Category.find("#{params[:parent_id]}").children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end




  private

  def item_params
    params.require(:item).permit(:product_name, :description, :category_parent_id, :category_child_id, :category_id, :condition_id, :delivery_burden_id, :shipping_address_id, :shipping_day_id, :price, images: []).merge(user_id: current_user.id, images: uploaded_images)
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

  def search_item
    @p = Item.ransack(params[:q])  # 検索オブジェクトを生成
    
  end

  def set_category_column
    @category_name = Category.select("name").distinct
  end
  
  def search_params
    params.permit(:sorts)
    # 他のパラメーターもここに入れる
  end

  def uploaded_images
    params[:item][:images].map{|id| ActiveStorage::Blob.find(id)} if params[:item][:images]
    # ActiveStorage::Blob.unattached.find_each(&:purge)  
  end

  def create_blob(uploading_file)
    ActiveStorage::Blob.create_after_upload! \
      io: uploading_file.open,
      filename: uploading_file.original_filename,
      content_type: uploading_file.content_type
  end
end
