class DriversController < ApplicationController
  before_action :set_driver, only: [:show, :edit, :update, :destroy, :setlocation]

  def index
    @drivers = Driver.all
  end
  
  def show
  end

  def new
    @driver = Driver.new
  end

  def edit
  end

  def setlocation
  end

  def create
    @driver = Driver.new(driver_params)

    respond_to do |format|
      if @driver.save
        format.html { redirect_to drivers_url, notice: 'Driver was successfully created.' }
        format.json { render :show, status: :created, location: @driver }
      else
        format.html { render :new }
        format.json { render json: @driver.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if !params[:driver][:location].nil?
        @driver.location = @driver.set_location

        if @driver.update(driver_location_params)
          format.html { redirect_to drivers_url, notice: 'Location was successfully updated.' }
          format.json { render :show, status: :ok, location: @driver }
        else
          format.html { render :setlocation }
          format.json { render json: @driver.errors, status: :unprocessable_entity }
        end

      else
        if @driver.update(driver_params)
          format.html { redirect_to drivers_url, notice: 'Driver was successfully updated.' }
          format.json { render :show, status: :ok, location: @driver }
          @drivers = Driver.all
        else
          format.html { render :edit }
          format.json { render json: @driver.errors, status: :unprocessable_entity }
        end
      end

      
    end
  end
  
  def destroy
    @driver.destroy
    respond_to do |format|
      format.html { redirect_to drivers_url, notice: 'Driver was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_driver
    @driver = Driver.find(params[:id])
  end

  def driver_location_params
    params.require(:driver).permit(:location)
  end

  def driver_params
    params.require(:driver).permit(:username, :email, :vehicle_type, :password, :password_confirmation)
  end
end