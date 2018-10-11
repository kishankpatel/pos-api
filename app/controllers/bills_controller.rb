class BillsController < ApplicationController
  def index
    @bills = current_user.bills.order("created_at DESC")
  end

  def show
    @bill = current_user.bills.find_by_id(params[:id])
    if @bill.nil?
      flash[:alert] = "Bill not found."
      redirect_to bills_path
      return
    end
    @bill_items = @bill.bill_items
  end

  def new
    # byebug
    @items = current_user.items
    @bill = Bill.new
  end

  def create
    @bill = Bill.new(bill_params)
    if @bill.save
      @bill.update_attribute :created_by, current_user.id
      bill_items = Hash[params[:item_id].zip(params[:quantity])] 
      total_amount = 0
      net_amount = 0
      
      bill_items.each do |item_id, quantity|
        item = current_user.items.where("id = ?", item_id).first
        if item.present?  
          total_amount = total_amount + (item.price * quantity.to_i)
          BillItem.create(item_id: item_id, quantity: quantity, bill_id: @bill.id)
        end
      end
      net_amount = total_amount + (total_amount * 0.15)

      @bill.update_attributes(total_amount: total_amount, net_amount: net_amount)

    end
    flash[:notice] = "Bill created successfully."
    redirect_to bills_path
  end

  private
  
  def bill_params
    params.require(:bill).permit(:bill_to)
  end

end
