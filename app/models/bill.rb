class Bill < ApplicationRecord
	belongs_to :user
	belongs_to :creator, class_name: "User", foreign_key: "created_by"
	has_many :bill_items, dependent: :destroy
end
