class Admin::HomesController < ApplicationController

  def top
    range = Date.today.beginning_of_day..Date.today.end_of_day #　本日の0時〜23時59分までのデータを指定
    @order = Order.where(created_at: range) # 本日の注文データのみ取ってくる
  end

end
