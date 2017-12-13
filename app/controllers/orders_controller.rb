class OrdersController < ApplicationController

  skip_before_action :authorize, only: [:new, :create]

  def index
    @orders = Order.all
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

    # @order.user_id = session[:user_id]
    @order.distance = @order.distance
    @order.total_price = @order.total
    respond_to do |format|
      if @order.save
        # User.update_gopay_from_order(@order)

        format.html{render :show, notice: "orders successfully saved"}
      else
        format.html{render :new}
      end
    end
  end

  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html{redirect_to @order, notice:'Order was successfully updated!'}
      else
        format.html{render :edit}
      end
    end
  end

  def destroy
    respond_to do |format|
      if @order.destroy
        format.html{redirect_to orders_path, notice: "Order was successfully deleted"}
      end
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
