class Category < ActiveRecord::Base
  attr_accessible :name, :category_img_url
  has_many :courses
end