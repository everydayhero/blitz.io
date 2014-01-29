require 'rubygems'
require 'blitz'
require 'pp'
require 'blitz'

# Run a sprint
# sprint = Blitz::Curl.parse('-r california www.example.com')
# result = sprint.execute
# pp :duration => result.duration

# Or a Rush
$default_timeout = 30000
$default_headers = '--header "Accept-Encoding: gzip,deflate"'
$pattern = '-p 1-50:120'

def charity_search_load_test
  sprint create_curl("-v:query a[1,8] -X GET https://edherow.com/api/v2/search/charities?q=\#{query}&country_code=us")
end

def aggregate_search_load_test
  sprint create_curl("-v:query a[1,8] -X GET https://edherow.com/api/v2/search/aggregate?q=\#{query}&grouped=1&country_code=us")
end

def create_curl command
  "--timeout #{$default_timeout} #{$default_headers} --status 200 #{command}"
end

def rush command
  rush = Blitz::Curl.parse "#{$pattern} #{command}"
  rush.execute do |partial|
      pp [ partial.region, partial.timeline.last.hits ]
  end
end

def sprint command
  sprint = Blitz::Curl.parse command
  result = sprint.execute
  pp :duration => result.duration
end

charity_search_load_test
aggregate_search_load_test
