require 'spec_helper'

describe Course do
  let(:course) { FactoryGirl.create(:course) }
  it "should have a title attribute" do
    expect(course).to respond_to :title
  end

  it "should have a description attribute" do
    expect(course).to respond_to :description
  end

  it "should have a url attribute" do
    expect(course).to respond_to :course_url
  end

  it "should have a start date attribute" do
    expect(course).to respond_to :start_date
  end

  it "should have an end date attribute" do
    expect(course).to respond_to :end_date
  end

  describe "search" do
    it "should return courses with matching content" do
      expect(Course.search_for("math")[0]).to eq Course.find_by_title("Math")
      expect(Course.search_for("ALGEBRA")[0]).to eq Course.find_by_title("Math")
    end
  end

  describe "filter" do
    let!(:course) { FactoryGirl.create(:course) }
    let!(:category) { FactoryGirl.create(:category) }
    let!(:school) { FactoryGirl.create(:school) }
    it "should return courses with filter" do
      expect(Course.filter("Math")[0]).to eq Course.find_by_category_id(1)
      expect(Course.filter("Hogwarts")[0]).to eq Course.find_by_school_id(1)
    end
  end
end