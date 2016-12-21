class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # this makes sure a user is signed in before he makes an orders
  before_action :authenticate_user!

# the below methods are creating an order history and a buyer history page. the routes have been set up in the routes file.
  def sales
    @orders = Order.all.where(seller: current_user).order("created_at DESC")
  end

  def purchases
    @orders = Order.all.where(buyer: current_user).order("created_at DESC")
  end

  # GET /orders
  # GET /orders.json

#i have disabled the

# INDEX AND SHOW ORDER PAGE HAS BEEN DISABLED ORDER PAGE HAS BEEN EDITED SO USERS CAN EDIT THERE PREVIOUS ORDERS

  # def index
  #  @orders = Order.all
#  end

  # GET /orders/1
  # GET /orders/1.json
#  def show
  #end

  # GET /orders/new
  def new
    @order = Order.new
    @listing = Listing.find(params[:listing_id])
  end

  # GET /orders/1/edit
#  def edit
#  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @listing = Listing.find(params[:listing_id])
  # this tells rails it can find the ID for the listing in the URL
  #the below means the  seller = to the user how created the listing
    @seller = @listing.user


    @order.listing_id = @listing.id
    # this tells rails that the buyer id is equal to the current user id
    @order.buyer_id = current_user.id
    @order.seller_id = @seller.id

#this first line tells stripe the secret key i added earlier from the stripe site and tells what acc to charge
    Stripe.api_key = ENV["STRIPE_API_KEY"]
# looks in the submitted form data. then pulls out the token stipe has given us, and hides it in the token.
    token = params[:stripeToken]

#this code is available on the stripe API page for charging accounts
    begin
      charge = Stripe::Charge.create(
        :amount => (@listing.price * 100).floor,
        :currency => "eur",
        :card => token
        )
      flash[:notice] = "Thank you for ordering, Come back soon!"
    rescue Stripe::CardError => e
      flash[:danger] = e.message
    end




    respond_to do |format|
      if @order.save
        format.html { redirect_to root_url}
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
#  def update
  #  respond_to do |format|
  ###    if @order.update(order_params)
  #      format.html { redirect_to @order, notice: 'Order was successfully updated.' }
  #      format.json { render :show, status: :ok, location: @order }
  #    else
  #      format.html { render :edit }
  #      format.json { render json: @order.errors, status: :unprocessable_entity }
  #    end
  ##  end
  # end

  # DELETE /orders/1
  # DELETE /orders/1.json
#  def destroy
#    @order.destroy
  #  respond_to do |format|
  #    format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
  #    format.json { head :no_content }
  #  end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:address, :city, :county)
    end
end
