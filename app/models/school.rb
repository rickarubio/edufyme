class School < ActiveRecord::Base
  attr_accessible :name, :school_url, :school_img_url
  has_many :courses
end