class ItemsController < ApplicationController

  layout 'profiles'


  before_action :authenticate_user!

  after_action :authorize_items, only: [:show, :update, :edit, :index]
  before_action :load_profile 


  def index
    policy_scope(Item)
    @items = @user.items.where(item_type: params[:item_type])
  end

  def new
  end

  def create
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

end
