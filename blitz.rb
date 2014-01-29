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
$pattern = '-p 1-50:120,50-50:60'

def charity_search_load_test
  rush create_curl("-v:query a[1,8] -X GET https://edherow.com/api/v2/search/charities?q=\#{query}&country_code=us")
end

def aggregate_search_load_test
  rush create_curl("-v:query a[1,8] -X GET https://edherow.com/api/v2/search/aggregate?q=\#{query}&grouped=1&country_code=us")
end

def view_supporter_page_load_test
  page_slugs = "[john-radcliffe,coralee-mary,grace-pritchard,michael-bohlscheid,david-gannon07-bigpond-com,kelly-haywood,playworksoz,walking4talking,claire-summerer,kiaana-brown]"
  rush create_curl("-v:slug #{page_slugs} -X GET https://give.edherow.com/au/\#{slug}")
end

def create_curl command, region = 'virginia'
  "--timeout #{$default_timeout} #{$default_headers} --region #{region} --status 200 #{command}"
end

def rush command
  ['singapore', 'virginia'].each do |region|
    rush = Blitz::Curl.parse "--region #{region} {$pattern} #{command}"
    pp "Executing #{rush.inspect}"
    rush.execute do |partial|
      pp [ partial.region, partial.timeline.last.hits ]
    end
  end
end

def sprint command
  pp "Executing #{command}"
  sprint = Blitz::Curl.parse command
  result = sprint.execute
  pp :duration => result.duration
end

charity_search_load_test
# aggregate_search_load_test
# view_supporter_page_load_test
