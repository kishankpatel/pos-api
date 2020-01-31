class Bill < ApplicationRecord
	belongs_to :user, optional: true
	belongs_to :creator, class_name: "User", foreign_key: "created_by", optional: true
	has_many :bill_items, dependent: :destroy

  def save_bill_items(params, current_user)
    bill_items = Hash[params[:item_id].zip(params[:quantity])] 
    total_amount = 0
    net_amount = 0
    
    bill_items.each do |item_id, quantity|
      item = current_user.items.where("id = ?", item_id).first
      if item.present?  
        total_amount = total_amount + (item.price * quantity.to_i)
        BillItem.create(item_id: item_id, quantity: quantity, bill_id: id)
      end
    end
    net_amount = total_amount + (total_amount * 0.15)

    self.update_attributes(total_amount: total_amount, net_amount: net_amount)
  end
end
