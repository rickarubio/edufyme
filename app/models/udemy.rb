class Udemy
  @@school = School.create(name: "Udemy", school_url: "https://www.udemy.com", school_img_url: "") #Necessary for associating all Udemy courses to a single school_id.

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
      doc = nil #This line is necessary to start the recursive call.
      doc = category_url.search('.last a').map { |link| link['href'] } #Nokogiri looking for "Next" button
      counter += 1
      courses = category_url.search('.course-card-wide a').map { |link| link['href'] } #Creating an array of course_urls
      img_links = category_url.search('.thumb img').map { |img| img['src'] } #find img links
      courses.each_with_index do |course, idx|
        Udemy.parse_course_page(Nokogiri::HTML(HTTParty.get(course)), img_links[idx]) #Parsing each course_url and passing to next method for creation.
      end
      new_category_page = Nokogiri::HTML(HTTParty.get("https://www.udemy.com/courses/#{category}/?price=free&view=list&lang=en&p=#{counter}"))
      Udemy.find_all_courses(new_category_page, category, counter, doc) #Recursive call to iterate through each category page
    end
  end

  def self.parse_course_page(doc, img_link)
    title_unformatted = doc.search('.ci-h').inner_text
    title = title_unformatted.gsub("\n", '').strip
    description_unformatted = doc.search('.cd-b').inner_text
    description = description_unformatted.gsub(/\r\n|\r|\n/, ' ').gsub(/\s{2,}/, ' ').strip
    course_url = doc.search('link[rel=canonical]').map { |link| link['href'] }.join
    teachers_unformatted = doc.search('.tb-r a').inner_text
    teachers = teachers_unformatted.gsub("\n", '').strip
    Course.create(
      title: title,
      school_id: @@school.id,
      description: description,
      course_url: course_url,
      course_img_url: img_link,
      start_date: "",
      teachers: teachers)
  end

end