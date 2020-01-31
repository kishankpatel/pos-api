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
    @items = current_user.items
    @bill = Bill.new
  end

  def create
    @bill = Bill.new(bill_params)
    respond_to do |format|
      if @bill.save
        @bill.update_attribute :created_by, current_user.id
        @bill.save_bill_items(params, current_user)

        format.html { redirect_to root_path, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @bill }
      else
        format.html { render :new }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  
  def bill_params
    params.require(:bill).permit(:bill_to)
  end

end
