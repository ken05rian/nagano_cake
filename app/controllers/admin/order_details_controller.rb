class Admin::OrderDetailsController < ApplicationController
  def update
    #order = Order.find(params[:order_id])
    order_detail = OrderDetail.find(params[:id])
    order_details = order_detail.order.order_details
    order_detail.update(order_detail_params)


    if  order_detail.making_status == '製作中'
        order_detail.order.status = "製作中"
        order_detail.order.save
    end

    if  order_details.all? {|detail| detail.making_status == '製作完了'}
        order_detail.order.status = "発送待ち"
        order_detail.order.save
    end

    redirect_to admin_order_path(params[:order_id])
  end

  private

  def order_detail_params
    params.permit(:making_status)
  end
end
