class Order < ActiveRecord::Base

  validates :address, :city, :county, presence: true

# every  order belongs to a listing
    belongs_to :listing

# this tells rails that a buyer is a type of user and so is seller.
    belongs_to :buyer, class_name: "User"
    belongs_to :seller, class_name: "User"
end
