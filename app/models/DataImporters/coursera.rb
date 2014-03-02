require 'httparty'
require 'pry'

class Coursera
  test = HTTParty.get('https://www.coursera.org/maestro/api/topic/list?full=1%20or%20https://www.coursera.org/maestro/api/topic/list2')
  binding.pry
end