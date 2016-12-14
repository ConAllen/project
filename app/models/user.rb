class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable


# the below  validation code is to ensure the user enters a name
          validates :name, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


# this means a listing exsisting, depends on the user. if the user is deleted the listing will also be deleted
         has_many :listings, dependent: :destroy
end
