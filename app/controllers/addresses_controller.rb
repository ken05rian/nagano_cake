class AddressesController < ApplicationController
  def index
    @addresses = current_customer.addresses
    @address = Address.new
  end

  def edit
    @address = Address.find(params[:id])
  end

  def create
    @address = current_customer.addresses.build(address_params)
    @address.save!
    redirect_to addresses_path
  end

  def update
    @address = Address.find(params[:id])
    @address.update(address_params)
    redirect_to addresses_path
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to addresses_path


  end

  private

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end

end

