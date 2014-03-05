class Coursera
  @all_courses = HTTParty.get('https://www.coursera.org/maestro/api/topic/list?full=1%20or%20https://www.coursera.org/maestro/api/topic/list2')

  def self.boom!
    formatted_courses = @all_courses.map do |course|
      {
        title: course["name"],
        description: Coursera.populate_course_descriptions(course['short_name']),
        course_url: "https://www.coursera.org/course/#{course['short_name']}",
        course_img_url: course["photo"],
        start_date: Coursera.populate_start_dates(course),
        school_id: Coursera.populate_school(course),
        teachers: course["instructor"]
      }
    end
    formatted_courses.each {|course| Course.create(course)}
  end

private
  def self.populate_school(course)
    school = {
      name: course["universities"][0]["name"],
      school_url: course["universities"][0]["home_link"],
      school_img_url: course["universities"][0]["logo"]
    }
    School.create(school).id
  end

  def self.populate_course_descriptions(short_name)
    course_data = HTTParty.get("https://www.coursera.org/maestro/api/topic/information?topic-id=#{short_name}")
    doc = Nokogiri::HTML(course_data['about_the_course'])
    description = doc.css('p').inner_text
    if description == ""
      description = course_data.parsed_response["about_the_course"]
      description.gsub(/<[^>]*>/, "").gsub("\n", ' ')
    else
      description.gsub("\n", '').gsub(/\s{2,}/, " ")
    end
  end

  def self.populate_start_dates(course)
    course_dates = []
    course["courses"].each do |course_instance|
      course_dates << "#{course_instance["start_year"]}-#{course_instance["start_month"]}-#{course_instance["start_day"]}"
    end
    course_dates.select! {|date| date.match(/\d{4}-\d{1,2}-\d{1,2}/)}
    starting_dates = course_dates.select do |date|
      (Chronic.parse(date) > Chronic.parse("today")) || (Chronic.parse(date) == Chronic.parse("today at noon"))
    end
    starting_dates.first # the soonest start date for that class
  end
end