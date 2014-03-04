class School < ActiveRecord::Base
  attr_accessible :name, :school_url, :school_img_url
  has_many :courses

  def self.short_school_name(school_name)
    max_school_name_length = 39
    school_name.slice(0, max_school_name_length)
  end
end