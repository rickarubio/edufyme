require 'spec_helper'

describe HomeController do
  context "#index" do
    let!(:course) { FactoryGirl.create(:course) }
    it "should have a sample of courses" do
      get :index
      expect(assigns(:courses)).to eq Course.all
    end
  end
end