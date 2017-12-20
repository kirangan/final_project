require 'rails_helper'

describe OrdersController do
  before :each do
    driver = create(:driver, location: "Tanah abang 3")
    session[:driver_id] = driver.id

    user = create(:user)
    session[:user_id] = user.id
  end
  
  describe 'GET #index' do
    it "populates an array of all orders" do 
      order1 = create(:order, origin: " Sabang Jakarta")
      order2 = create(:order, origin: " Tanah Abang 2")
      get :index
      expect(assigns(:orders)).to match_array([order1, order2])
    end

    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    it "assigns the requested order to @order" do
      order = create(:order)
      get :show, params: { id: order }
      expect(assigns(:order)).to eq order
    end

    it "renders the :show template" do
      order = create(:order)
      get :show, params: { id: order }
      expect(response).to render_template :show
    end
  end


  describe 'GET #new' do
    it "assigns a new Order to @order" do
      get :new
      expect(assigns(:order)).to be_a_new(Order)
    end

    it "renders the :new template" do
      get :new
      expect(:response).to render_template :new
    end
 
    it "redirects to the order page" do
      get :new
      expect(:response).to redirect_to orders_url
    end
  end

   describe 'POST #create' do
    context "with valid attributes" do
      it "saves the new order in the database" do
        expect{
          post :create, params: { order: attributes_for(:order) }
        }.to change(Order, :count).by(1)
      end

      it "redirects to order index page" do
        post :create, params: { order: attributes_for(:order) }
        expect(response).to redirect_to orders_url
      end
    end

    context "with invalid attributes" do
      it "does not save the new order in the database" do
        expect{
          post :create, params: { order: attributes_for(:invalid_order) }
        }.not_to change(Order, :count)
      end

      it "re-renders the :new template" do
        post :create, params: { order: attributes_for(:invalid_order) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @order = create(:order)
    end

    it "deletes the order from the database" do
      expect{
        delete :destroy, params: { id: @order }
      }.to change(Order, :count).by(-1)
    end

    it "redirects to orders#index" do
      delete :destroy, params: { id: @order }
      expect(response).to redirect_to orders_url
    end
  end
end


