class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable


# the below  validation code is to ensure the user enters a name
          validates :name, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


# this means a listing exsisting, depends on the user. if the user is deleted the listing will also be deleted
         has_many :listings, dependent: :destroy
         
#this tells rails that a user has many sales. they have orders that they purchased and sales they have sold.
         has_many :sales, class_name: "Order", foreign_key: "seller_id"
         has_many :purchases, class_name: "Order", foreign_key: "buyer_id"
end
