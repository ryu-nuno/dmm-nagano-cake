class Public::AddressController < ApplicationController
  
  before_action :authenticate_member!
  def index
  	@addresses = current_member.addresses.all
  	@address = Address.new
  end

  def create
  	@address = Address.new(address_params)
  	@address.member_id = current_member.id
  	@address.save
  	redirect_to public_addresses_path
  end

  def edit
  	@address = Address.find(params[:id])
  end

  def update
  	@address = Address.find(params[:id])
  	@address.update(address_params)
  	redirect_to public_addresses_path
  end

  def destroy
  	@address = Address.find(params[:id])
  	@address.destroy
  	redirect_to public_addresses_path
  end

  private
  
  def address_params
  	params.require(:address).permit(:name, :customer_id, :address, :postal_code)
  end
end
