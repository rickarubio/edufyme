require 'spec_helper'

describe School do
  it { should respond_to :name }
  it { should respond_to :school_url }
  it { should respond_to :school_img_url }
end