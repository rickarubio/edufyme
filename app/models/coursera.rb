class Coursera
  @all_courses = HTTParty.get('https://www.coursera.org/maestro/api/topic/list?full=1%20or%20https://www.coursera.org/maestro/api/topic/list2')

  def self.populate_courses
    formatted_courses = @all_courses.map do |course|
      {
        title: course["name"],
        description: "pending NOKOGIRI scraping logic",
        course_url: "https://www.coursera.org/course/#{course['short_name']}",
        course_img_url: course["photo"],
        start_date: nil,
        end_date: nil,
        short_description: course["short_description"]
      }
    end
    formatted_courses.each {|course| Course.create(course)}
  end

end