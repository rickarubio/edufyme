require 'spec_helper'

describe Course do
  it { should respond_to :title}
  it { should respond_to :description}
  it { should respond_to :course_url}
  it { should respond_to :course_img_url}
  it { should respond_to :start_date}
  it { should respond_to :teachers}
end