require 'spec_helper'

# describe Course do
#   let(:course) { FactoryGirl.create(:course) }
#   it "has a title attribute" do
#     expect(course).to respond_to :title
#   end

#   it "has a description attribute" do
#     expect(course).to respond_to :description
#   end

#   it "has an url attribute" do
#     expect(course).to respond_to :course_url
#   end

#   it "has a start date attribute" do
#     expect(course).to respond_to :start_date
#   end

#   it "has at least one instructor" do
#     expect(course).to respond_to :teachers
#   end

# end
describe Course do
  it { should respond_to :title}
  it { should respond_to :description}
  it { should respond_to :course_url}
  it { should respond_to :course_img_url}
  it { should respond_to :start_date}
  it { should respond_to :teachers}
end