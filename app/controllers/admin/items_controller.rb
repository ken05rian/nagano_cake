class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all.includes(:genre).page(params[:page]).per(10)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.save!
    redirect_to admin_item_path(@item.id)
  end

  def show
    @item = Item.find(params[:id])
    @price = @item.price*1.1
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
     @item = Item.find(params[:id])
     @item.update(item_params)
     @item.save!
     redirect_to admin_item_path(@item.id)
  end

 private

  def item_params
    params.require(:item).permit(:image, :name, :introduction, :genre_id, :price, :is_active)
  end

end