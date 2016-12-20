class Listing < ActiveRecord::Base

  has_attached_file :image, styles: { medium: "200x>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
# the below code validates the listing page. it means you need to have description and price
  validates :name, :description, :price, presence: true
  #the blow model validation makes sure the price is greater the 0
  validates :price, numericality: { greater_than: 0 }
  validates :name, presence: true

# each listing belongs to a user
  belongs_to :user

#each listing can have many orders
  has_many :orders

end
