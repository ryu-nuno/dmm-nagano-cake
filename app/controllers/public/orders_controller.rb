class Public::OrdersController < ApplicationController
    before_action :authenticate_customer!
    before_action :correct_order, only: [:edit,:show]


    def new
        @order = Order.new
    end

    def confirm
        @order = Order.new(order_params)
        @total = 0
        @shipping_cost =800
        @cart_items = current_customer.cart_items
        @order_infomation = params[:order][:address_type]
        if @order_infomation == "0"
            @order.address =current_customer.address
            @order.postal_code = current_customer.postal_code
            @order.name = current_customer.first_name+current_customer.last_name
        elsif @order_infomation == "1"
            address = Address.find(params[:order][:address].to_i)
            @order.address = address.address
            @order.postal_code = address.postal_code
            @order.name = address.name
        elsif @order_infomation == "2"
            address = Address.new(postal_code:  params[:order][:new_postal_code], address: params[:order][:new_address], name: params[:order][:new_name])
            address.customer_id = current_customer.id
            address.save!
            @order.address = address.address
            @order.postal_code = address.postal_code
            @order.name = address.name
        end



    end

    def complete
    end

    def create
        @order = Order.new(order_params)
        @order.customer_id = current_customer.id
        @total = 0

        if @order.save
            current_customer.cart_items.each do |cart_item|
               order_detail= OrderDetail.new(item_id: cart_item.item_id,amount: cart_item.amount,price: cart_item.item.price )
               order_detail.order_id = @order.id
               order_detail.save
               cart_item.destroy
            end
            redirect_to public_orders_complete_path
        else
            render "new"
        end
    end

    def index
        @orders = Order.where(customer_id: current_customer.id)
    end

    def show
        @order = Order.find(params[:id])
        @order_items = @order.order_details
        @total = 0
        @shipping_cost =800
    end

    def correct_order
          @order = Order.find(params[:id])
      unless @order.customer.id == current_customer.id
        redirect_to new_customer_session_path
      end
    end

    private

    def order_params
        params.require(:order).permit(:name,:postal_code, :address, :payment_method, :shipping_cost, :total_payment)
    end
end
