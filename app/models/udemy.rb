class Udemy
  @@school = School.create(name: "Udemy", school_url: "https://www.udemy.com", school_img_url: "")

  def self.boom!
    Udemy.parse_categories
  end

  private

  def self.parse_categories
    categories = ["Technology", "Business", "Design", "Arts-and-Photography", "Health-and-Fitness", "Lifestyle", "Math-and-Science", "Education", "Languages", "Humanities", "Social-Sciences", "Music", "Crafts-and-Hobbies", "Sports", "Games", "Other"]
    categories.each do |category|
      counter = 1
      first_category_url = Nokogiri::HTML(HTTParty.get("https://www.udemy.com/courses/#{category}/?price=free&view=list&lang=en&p=1"))
      Udemy.find_all_courses(first_category_url, category, counter)
    end
  end

  def self.find_all_courses(category_url, category, counter, doc=[""])
    unless doc.empty?
      doc = nil
      doc = category_url.search('.last a').map { |link| link['href'] }
      counter += 1
      courses = category_url.search('.course-card-wide a').map { |link| link['href'] }
      courses.each do |course|
        Udemy.parse_course_page(Nokogiri::HTML(HTTParty.get(course)), category_url)
      end
      new_category_page = Nokogiri::HTML(HTTParty.get("https://www.udemy.com/courses/#{category}/?price=free&view=list&lang=en&p=#{counter}"))
      Udemy.find_all_courses(new_category_page, category, counter, doc)
    end
  end

  def self.parse_course_page(doc, category_url)
    title_unformatted = doc.search('.ci-h').inner_text
    title = title_unformatted.gsub("\n", '').strip
    description_unformatted = doc.search('.cd-b').inner_text
    description = description_unformatted.gsub("\n", '').gsub("\r", ' ').gsub(/\s{2,}/, ' ').strip
    course_url = doc.search('link[rel=canonical]').map { |link| link['href'] }.join
    teachers_unformatted = doc.search('.tb-r a').inner_text
    teachers = teachers_unformatted.gsub("\n", '').strip
    Course.create(
      title: title,
      school_id: @@school.id,
      description: description,
      course_url: course_url,
      course_img_url: "https://lh5.googleusercontent.com/6y8GX8vHLIM9uzTleVsSArreEccq8UGKGari56W9NnfdGevRIpr8DYDllyNJWWT3-j4f8vwo941rJ_WR_Ooe4s7uggbDVB9q-BsOiQ51fgjewS3APB8PGWbK",
      start_date: "", 
      teachers: teachers)
  end

end