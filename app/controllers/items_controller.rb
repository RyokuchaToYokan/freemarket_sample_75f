class ItemsController < ApplicationController
  before_action :set_parent_categories, only: [:new, :create]
  before_action :signed_in?, only: [:new, :create]

  def index
  end

  def new
    @item = Item.new
    @item.images.build
  end

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
    if @item.save
      redirect_to root_path
    else
      @item.images.build
      render :new
    end
  end

  def edit
  end

  def update
  end

  def show
    @item= Item.find(11)
    @grandchild= @item.category
    @child= @item.category.parent
    @parent= @child.parent
    @preparation = @item.preparation.name
    @condition= @item.condition.name
    @address= @item.user.address.prefecture.name
    @images= @item.images.all
    @size= @item.size
    @brand= @item.brand.name
    @picture= @item.images
    @tax = 1.1
  end

  def get_child_categories
    parent_category = Category.find(params[:id])
    @child_categories = parent_category.children
  end

  def get_grandchild_categories
    child_category = Category.find(params[:id])
    @grandchild_categories = child_category.children
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :brand_id, :condition_id, :postage_payment_id, :ship_from_id, :preparation_id, :price, images_attributes: [:picture]).merge(user_id: current_user.id)
  end

  def set_parent_categories
    @parent_categories = Category.where(ancestry: nil)
  end

  def signed_in?
    redirect_to new_user_session_path unless user_signed_in?
  end

end
