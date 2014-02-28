def seed_schools
  school_images = [
    "http://studentcompetitions-general.s3.amazonaws.com/cyp-2014/img/lundsuniversitet_-_b.jpg",
    "http://www.studyco.com/upload/images/oxford_university(1).jpg",
    "http://www.hdpaperwall.com/wp-content/uploads/2013/11/Harvard-University.jpg",
    "http://www.huntington-study-group.org/Portals/0/University%20of%20tennessee.jpg"]
  10.times do
    School.create(
      name: (Faker::Company.name + " University"),
      school_url: ("http://www." + Faker::Internet.domain_name),
      school_img_url: school_images.sample
      )
  end
end

def seed_categories
  categories = [
    "Mathematics",
    "Chemistry",
    "Engineering",
    "Cryptozoology",
    "Mysticism"]
  category_img_urls = [
    "http://upload.wikimedia.org/wikipedia/commons/8/89/Pure-mathematics-formul%C3%A6-blackboard.jpg",
    "http://www.dvc.edu/org/images/beakers.jpg",
    "http://rossengineers.com/wp-content/themes/rosseng/img/j0439299.jpg",
    "http://images5.fanpop.com/image/photos/31400000/Nessie-cryptozoology-31461575-1024-768.jpg",
    "http://www.seedsofunfolding.org/issues/11_08/Mysticism.jpg"]
  category_index = 0
  5.times do
    Category.create(
      name: categories[category_index],
      category_img_url: category_img_urls[category_index])
    category_index += 1
  end
end

def seed_courses
  course_numbers = [101, 206, 314, 424]
  100.times do
    random_num = rand(10)
    Course.create(
      school_id: School.all.sample.id,
      category_id: Category.all.sample.id,
      title: Faker::Company.bs + " " + course_numbers.sample.to_s,
      description: Faker::Lorem.paragraphs,
      course_url: ("http://www." + Faker::Internet.domain_name),
      course_img_url: "https://www.irwachapter4.org/wp-content/uploads/2010/09/coursesoffered.jpg",
      start_date: rand(random_num).days.ago(Date.today),
      end_date: rand(random_num).days.from_now)
  end
end

def seed_teachers
  40.times do
    Teacher.create(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      teacher_img_url: "http://casaguides.nrao.edu/images/c/c7/Einstein.jpg",
      teacher_url: ("http://www." + Faker::Internet.domain_name))
  end
end

def seed_users
  #implemented by spencer
end

def seed_course_users
end

def seed_course_teachers
end

def run_once
  seed_schools
  seed_categories
  seed_courses
  seed_teachers
  seed_users
  seed_course_users
  seed_course_teachers
end

run_once