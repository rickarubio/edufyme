require 'spec_helper'

describe Category do
  let(:category) { FactoryGirl.create(:category) }
  it { should respond_to :name }
  it { should respond_to :category_img_url }
  it { should respond_to :courses }
end