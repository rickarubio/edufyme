class Course < ActiveRecord::Base
  attr_accessible :school_id, :title, :description, :course_url,
    :course_img_url, :start_date, :teachers
  belongs_to :school
  has_many :course_users
  has_many :users, :through => :course_users

  def self.featured
    Course.all.sample(9)
  end

  def self.search_for(search_terms)
    search_terms = search_terms.downcase.split(' ')
    results = []

    # check the title, if there's no match, check the description, for each course
    # ie: 'ruby programming' in title or 'ruby programming' description
    results << Course.all.select do |course| 
      course.title.downcase.match(search_terms.join(' ')) || course.description.downcase.match(search_terms.join(' '))
    end

    # check the title for each search term individually
    # ie: 'ruby' in title or 'programming' in title
    search_terms.each do |term|
      Course.all.each do |course|
        results.push(course) if course.title.downcase.match(term)
      end
    end

    # check the description for each search term individually
    # ie: 'ruby' anywhere in the title or 'programming' anywhere in title
    search_terms.each do |term|
      Course.all.each do |course|
        results.push(course) if course.description.downcase.match(term)
      end
    end

    # remove duplicates and return the results back to the caller
    results.flatten.uniq.map {|course| course}
  end

  def short_title
    max_title_length = 36
    self.title.slice(0, max_title_length)
  end

end