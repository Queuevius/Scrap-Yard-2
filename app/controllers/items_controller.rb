class ItemsController < ApplicationController

  layout 'profiles'


  before_action :authenticate_user!

  after_action :authorize_items, only: [:show, :update, :edit, :index, :new, :create]
  before_action :load_profile 


  def index
    policy_scope(Item)
    @item_type = params[:item_type].blank? ? "have" : params[:item_type]  
    @items = @user.items.where(item_type: params[:item_type])
  end

  def new
    @item = @user.items.build
    @item_type = params[:item_type]
  end

  def create
    @item = @user.items.build(item_params)
    @item.save
    @items = @user.items.where(item_type: @item.item_type)
    @item_type = @item.item_type
    render :index
  end

  def show
  end

  def update
  end






  private 
  
  def authorize_items
    authorize Item
  end

  def load_profile
    @user = User.friendly.find(params[:id])
    @profile = @user.profile
  end

  def item_params
    params.require(:item).permit(:title , :details , :item_type)
  end

end
