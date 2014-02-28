def seed_schools
  school_images = [
    "http://studentcompetitions-general.s3.amazonaws.com/cyp-2014/img/lundsuniversitet_-_b.jpg",
    "http://www.studyco.com/upload/images/oxford_university(1).jpg",
    "http://www.hdpaperwall.com/wp-content/uploads/2013/11/Harvard-University.jpg",
    "http://www.huntington-study-group.org/Portals/0/University%20of%20tennessee.jpg"]
  5.times do
    School.create(
      name: (Faker::Company.name + " University"),
      school_url: ("http://www." + Faker::Internet.domain_name)
      school_img_url: school_images.sample
      )
  end
end

def seed_courses
  50.times do
    Course.create(
      )
  end
end



def seed_categories
end

def seed_teachers
end

def seed_users
end

def seed_course_users
end

def seed_course_teachers
end

def run_once
  seed_schools
  seed_courses
  seed_categories
  seed_teachers
  seed_users
  seed_course_users
  seed_course_teachers
end

run_once
