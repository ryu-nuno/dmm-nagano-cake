class Public::CartItemsController < ApplicationController
    before_action :setup_cart_item, only: [:create]

    def index
        @cart_items = current_customer.cart_items
        @total_price = 0
        @cart_items.each do |cart_item|
            @total_price += cart_item.item.price * cart_item.amount * 1.1
        end
    end

    def create
        if @cart_item.blank?
            @cart_item = current_customer.cart_items.new(cart_item_params)
            #binding.pry
        else
            @cart_item.amount += params[:cart_item][:amount].to_i
        end

        @cart_item.save
        redirect_to cart_items_path
    end

    def update
        cart_item = CartItem.find(params[:id])
        cart_item.update(amount: params[:cart_item][:amount].to_i)
        #binding.pry
        redirect_to cart_items_path
    end

    def destroy
        cart_item = CartItem.find(params[:id])
        cart_item.destroy
        redirect_to cart_items_path
    end

    def destroy_all
        @cart_items = current_customer.cart_items
        @cart_items.destroy_all
        redirect_to cart_items_path

    end

    private

    def cart_item_params
         params.require(:cart_item).permit(:item_id, :customer_id, :amount)
    end

    def setup_cart_item
        @cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
    end


end
