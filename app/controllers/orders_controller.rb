class OrdersController < ApplicationController
  def new
    @order = current_customer.orders.build
    @addresses = current_customer.addresses
  end

def confirm
    @order = Order.new(order_params)
    @cart_items = CartItem.where(customer_id: current_customer.id)

      total_price = []
    @cart_items.each do |cart_item|
      total_price << (cart_item.item.price * cart_item.amount)
    @order.order_details.build({
      item: cart_item.item,
      price: cart_item.item.price,
      amount: cart_item.amount,
      making_status: ''
    })
    end
    @total_price = total_price.sum
    @order.total_payment = @total_price
    @order.status = '入金待ち'

    @address1 = current_customer.address
    @address2 = params[:order][:address2]
    @flag = params[:order][:flag]
    if params[:registered_address].present?
      @registered_address = Address.find(params[:registered_address])
    end
    @order.address = case @flag
                    when '1'
                          @address1
                    when '2'
                          @registered_address.address
                    when '3'
                          @address2
                    end
    @order.postal_code = case @flag
                    when '1'
                          current_customer.postal_code
                    when '2'
                          @registered_address.postal_code
                    when '3'
                          params[:order][:postal_code]
                    end
    @order.name = case @flag
                    when '1'
                          current_customer.first_name + current_customer.last_name
                    when '2'
                          @registered_address.name
                    when '3'
                          params[:order][:name]
                    end
end

  def complete
  end

  def create
    @order = current_customer.orders.build(order_params)
    @order.save!
    redirect_to orders_complete_path
  end

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

private

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status, {order_details_attributes: [:item_id, :amount, :price, :making_status]})
  end
end
