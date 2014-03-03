class Coursera
  @all_courses = HTTParty.get('https://www.coursera.org/maestro/api/topic/list?full=1%20or%20https://www.coursera.org/maestro/api/topic/list2')

  def self.populate_courses
    formatted_courses = @all_courses.map do |course|
      {
        title: course["name"],
        description: Coursera.populate_course_descriptions(course['short_name']),
        course_url: "https://www.coursera.org/course/#{course['short_name']}",
        course_img_url: course["photo"],
        start_date: nil,
        end_date: nil,
        short_description: course["short_description"]
      }
    end
    formatted_courses.each {|course| Course.create(course)}
  end

  def self.populate_course_descriptions(short_name)
    course_data = HTTParty.get("https://www.coursera.org/maestro/api/topic/information?topic-id=#{short_name}")
    doc = Nokogiri::HTML(course_data['about_the_course'])
    description = doc.css('p').inner_text
    description.gsub("\n", '').split(/ {2,}/).join('')
  end

end