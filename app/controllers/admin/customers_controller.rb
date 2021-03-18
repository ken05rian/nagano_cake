class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.all.page(params[:page]).per(10)
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to admin_customer_path(@customer)
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name,:last_name_kana,:first_name_kana,:address,:telephone_number,:postal_code).merge(is_active: ActiveRecord::Type::Boolean.new.cast(params[:customer][:is_active]))
  end
end
