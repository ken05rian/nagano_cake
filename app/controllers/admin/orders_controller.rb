class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @customer = @order.customer
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)

    if @order.status == '入金確認'
      @order.order_details.each do |order_detail|
        order_detail.making_status = "製作待ち"
        order_detail.save
      end
    end

    redirect_to admin_order_path(@order)

  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end
