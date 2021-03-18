class CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.all

    total_price = []
    @cart_items.each do |cart_item|
      total_price << (cart_item.item.price * cart_item.amount)
    end

    @total_price = total_price.sum
    #byebug
  end

  def update
    #byebug
     @cart_item = CartItem.find(params[:id])
     @cart_item.update(cart_update_params)
     redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
   CartItem.destroy_all
    redirect_to cart_items_path
  end

  def create
    p params
    @cart_item = current_customer.cart_items.new(cart_item_params)
    @cart_items = current_customer.cart_items.all
    @cart_items.each do |cart_item|

      if cart_item.item_id == @cart_item.item_id
        new_amount = cart_item.amount + @cart_item.amount
        cart_item.update_attribute(:amount, new_amount)
        @cart_item.delete
      end
    end

    @cart_item.save
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount,:customer_id)
  end


  def cart_update_params
    params.permit(:id, :amount)
  end
end

