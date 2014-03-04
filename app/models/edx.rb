class Edx

  def self.boom!
    parse_first_course_list
    find_course_list_length.times do |num|
      parse_course_lists(num)
    end

  end

  private

  def find_course_list_length
    list = Nokogiri::HTML(HTTParty.get("https://www.edx.org/course-list"))
    last_url = list.search('.pager-last a').map { |link| link['href'] }.join
    length = last_url.match(/\d+/).to_s.to_i
  end

  def parse_first_course_list
    doc = Nokogiri::HTML(HTTParty.get("https://www.edx.org/course-list"))
    titles = doc.search('.title').map { |font| font.inner_text }
    course_urls = doc.search('.title a').map { |link| link['href'] }
    start_dates = doc.search('.first li').map { |font| font.inner_text }
  end

  def self.parse_course_lists
    course_numbers =
    course_lists = HTTParty.get("https://www.edx.org/course-list")

  end

  def self.parse_courses(course_list_number)
    courses = HTTParty.get("https://www.edx.org/course-list?page=#{course_list_number}")
  end
end

#Course List
# https://www.edx.org/course-list
# https://www.edx.org/course-list?page=#{}

#Course Specific Page
# https://www.edx.org/course/mitx/mitx-15-071x-analytics-edge-1416
# https://www.edx.org/course/school_name/school_name-course-id-course-name-someidentifier
# "." in course ID are replaced by "-"

#Things we need
# title
# description
# course_url
# course_img_url
# start_date
# teachers
# school_name
