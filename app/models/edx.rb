class Edx

  def self.boom!
    Edx.find_course_list_length
  end

  private

  def self.find_course_list_length
    list = Nokogiri::HTML(HTTParty.get("https://www.edx.org/course-list"))
    last_url = list.search('.pager-last a').map { |link| link['href'] }.join
    length = last_url.match(/\d+/).to_s.to_i + 1
    Edx.parse_course_list_urls(length)
  end

  def self.parse_course_list_urls(length)
    length.times do |num|
      Edx.course_list_pages(Nokogiri::HTML(HTTParty.get("https://www.edx.org/course-list?page=#{num}")))
    end
  end

  def self.course_list_pages(urls)
    course_urls = urls.search('.title a').map { |link| link['href'] }
    Edx.aggregate_course_data(course_urls)
  end

  def self.aggregate_course_data(course_urls)
    course_urls.map do |url|
      doc = Nokogiri::HTML(HTTParty.get(url))
      school_name = doc.search('.course-detail-school a').inner_text
      school_url_partial = doc.search('.course-detail-school a').map { |link| link['href'] }.join
      school_url = "https://www.edx.org" + school_url_partial
      new_school = School.create(name: school_name, school_url: school_url, school_img_url: "")
      title = doc.search('.course-detail-title').map { |font| font.inner_text }.join
      start_dates_unformatted = doc.search('.course-detail-start').map { |font| font.inner_text }.join
      start_date = Edx.date_formatter(start_dates_unformatted)
      description = doc.search('.course-section p').inner_text
      course_img_url = doc.search('.course-detail-image img').map { |img| img['src'] }.join
      teachers = doc.search('.view-display-id-staff h4').map { |font| font.inner_text }.join(", ")
      Course.create(title: title, description: description, course_url: url, course_img_url: course_img_url, start_date: start_date, teachers: teachers, school_id: new_school.id )
    end
  end

  def self.date_formatter(start_date)
    start_date.gsub(/Classes Starts: /, '')
    if Chronic.parse(start_date)
      Chronic.parse(start_date).strftime('%Y-%m-%d')
    else
      start_date
    end
  end

end