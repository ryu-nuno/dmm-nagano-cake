class Admin::OrdersController < ApplicationController

  def index
    @path = Rails.application.routes.recognize_path(request.referer)
    if @path[:controller] == "admin/customers" && @path[:action] == "show"
       @order = Order.where(member_id: params[:format]).page(params[:page]).per(7)
    elsif @path[:controller] == "admin/homes"
       @order = Order.where(created_at: Time.zone.today.all_day).page(params[:page]).per(7)
    else
       @order = Order.page(params[:page]).per(7)
    end
  end
  
  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

  def update
    @order = Order.find(params[:id]) #注文詳細の特定
  	@order_items = @order.order_items #注文から紐付く商品の取得
  	@order.update(order_params) #注文ステータスの更新
  end


  def order_params
  	params.require(:order).permit(:status)
  end
end
