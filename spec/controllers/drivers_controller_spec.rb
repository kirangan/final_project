require 'rails_helper'

describe DriversController do
  before :each do
    @driver1 = create(:driver, drivername: "driver1")
    session[:driver_id] = @driver1.id
  end

  describe 'GET #index' do
    it "populates an array of all drivers" do
      driver2 = create(:driver, drivername: "driver2")
      get :index
      expect(assigns(:drivers)).to match_array([@driver1, driver2])
    end

    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    it "assigns the requested driver to @driver" do
      driver = create(:driver)
      get :show, params: { id: driver }
      expect(assigns(:driver)).to eq driver
    end

    it "renders the :show template" do
      driver = create(:driver)
      get :show, params: { id: driver }
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    it "assigns a new Driver to @driver" do
      get :new
      expect(assigns(:driver)).to be_a_new(Driver)
    end

    it "renders the :new template" do
      get :new
      expect(:response).to render_template :new
    end
  end

  describe 'GET #edit' do
    it "assigns the requested driver to @driver" do
      driver = create(:driver)
      get :edit, params: { id: driver}
      expect(assigns(:driver)).to eq driver
    end

    it "renders the :edit template" do
      driver = create(:driver)
      get :edit, params: { id: driver }
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    context "with valid attributes" do
      it "saves the new driver in the database" do
        expect{
          post :create, params: { driver: attributes_for(:driver) }
        }.to change(Driver, :count).by(1)
      end

      it "redirects to drivers#index" do
        post :create, params: { driver: attributes_for(:driver) }
        expect(response).to redirect_to drivers_url
      end
    end

    context "with invalid attributes" do
      it "does not save the new driver in the database" do
        expect{
          post :create, params: { driver: attributes_for(:invalid_driver) }
        }.not_to change(Driver, :count)
      end

      it "re-renders the :new template" do
        post :create, params: { driver: attributes_for(:invalid_driver) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    before :each do
      @driver = create(:driver, password: 'oldpassword', password_confirmation: 'oldpassword')
    end

    context "with valid attributes" do
      it "locates the requested @driver" do
        patch :update, params: { id: @driver, driver: attributes_for(:driver) }
        expect(assigns(:driver)).to eq @driver
      end

      it "saves new password" do
        patch :update, params: { id: @driver, driver: attributes_for(:driver, password: 'newlongpassword', password_confirmation: 'newlongpassword') }
        @driver.reload
        expect(@driver.authenticate('newlongpassword')).to eq(@driver)
      end

      it "redirects to drivers#index" do
        patch :update, params: { id: @driver, driver: attributes_for(:driver) }
        expect(response).to redirect_to drivers_url
      end

      it "disables login with old password" do
        patch :update, params: { id: @driver, driver: attributes_for(:driver, password: 'newlongpassword', password_confirmation: 'newlongpassword') }
        @driver.reload
        expect(@driver.authenticate('oldpassword')).to eq(false)
      end
    end

    context "with invalid attributes" do
      it "does not update the driver in the database" do
        patch :update, params: { id: @driver, driver: attributes_for(:driver, password: nil, password_confirmation: nil) }
        @driver.reload
        expect(@driver.authenticate(nil)).to eq(false)
      end

      it "re-renders the :edit template" do
        patch :update, params: { id: @driver, driver: attributes_for(:invalid_driver) }
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @driver = create(:driver)
    end

    it "deletes the driver from the database" do
      expect{
        delete :destroy, params: { id: @driver }
      }.to change(Driver, :count).by(-1)
    end

    it "redirects to drivers#index" do
      delete :destroy, params: { id: @driver }
      expect(response).to redirect_to drivers_url
    end
  end
end