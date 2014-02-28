require 'spec_helper'

describe Teacher do
  it { should respond_to :first_name }
  it { should respond_to :last_name }
  it { should respond_to :teacher_img_url }
  it { should respond_to :teacher_url }
  it { should respond_to :courses }
end