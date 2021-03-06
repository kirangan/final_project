class OrdersController < ApplicationController

  before_action :set_order, only: [:show, :edit, :update, :destroy ]
  skip_before_action :authorize, only: [:new, :create]

  def index
    if session[:role] == 'user'
      user = User.find(session[:user_id])
      @orders = user.orders
    elsif session[:role] == 'driver'
      driver = Driver.find(session[:driver_id])
      @orders = driver.orders
    else
      @orders = Order.all
    end
  end

  def show
  end

  def new
    @order = Order.new
  end

  def edit
  end

  def create
    @order = Order.new(order_params)

    @order.user_id = session[:user_id]
    @order.distance = @order.distance_length
    @order.total_price = @order.total
    @order.driver_id = @order.driver_near_first

    respond_to do |format|
      if @order.save
        User.update_gopay_from_order(@order)
        Driver.update_gopay_driver_from_order(@order)
        Driver.update_location_from_order(@order)

        format.html{ render :show, notice: "orders successfully saved"}
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html{ redirect_to @order, notice:'Order was successfully updated!' }
        format.json { render :show, status: :ok, location: @order }

        @orders = Order.all
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_path, notice: "Order was successfully deleted" }
      format.json { head :no_content }
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:mode, :origin, :destination, :payment)
  end
 
end
