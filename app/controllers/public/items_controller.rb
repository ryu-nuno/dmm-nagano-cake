class Public::ItemsController < ApplicationController
  def index
    @items = Item.where(is_active: 0).page(params[:page]).per(8) # where文で販売ステータスが販売中のものだけ表示させる/ページネーションの追加/8件ごとにページ作成
    @quantity = Item.count # quantity => 総量/.count =>カウントメソッド、配列の要素の数を数えるための機能
    @genres = Genre.where(valid_invalid_status: 0) # ジャンルの有効無効ステータスが有効のものだけ探す/除外検索
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @genres = Genre.where(valid_invalid_status: 0) # ジャンルの有効無効ステータスが有効のものだけ探す/除外検索
  end
end
