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

    # Check each course's title. Push in the matches.
    # ie: 'ruby programming' in title
    results << Course.all.select do |course| 
      course.title.downcase.match(search_terms.join(' ')))
    end

    # Check each course's description. Push in the matches.
    # ie: 'ruby programming' in description
    results << Course.all.select do |course| 
      course.description.downcase.match(search_terms.join(' ')))
    end

    # check the title for the first search term only
    # ie: 'ruby' anywhere in title
    Course.all.each do |course|
      results.push(course) if course.title.downcase.match(search_terms[0])
    end

    # check the description for the first search term only
    # ie: 'ruby' in description
    Course.all.each do |course|
      results.push(course) if course.description.downcase.match(search_terms[0])
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