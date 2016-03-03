#!/usr/bin/env ruby
require 'net/http'
require 'yaml'
require 'openssl'

include Net

##
# Helper method that is used to login to time edit. It takes a CID and the
# password associated with it and returns the Cookie that should be sent to
# time edit for authing further requests.
def login(cid, password)
  # Construct appropriate data for the request.
  url = URI('https://se.timeedit.net/web/chalmers/db1/b1/')

  http = HTTP.new(url.host, url.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  request = HTTP::Post.new(url)

  request["Accept"]                    = "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
  request["Accept-Encoding"]           = "gzip, deflate"
  request["Accept-Language"]           = "sv-SE,sv;q=0.8,en-US;q=0.6,en;q=0.4,nb;q=0.2"
  request["Cache-Control"]             = "max-age=0"
  request["Connection"]                = "keep-alive"
  request["Content-Length"]            = "112"
  request["Content-Type"]              = "application/x-www-form-urlencoded"
  request["Host"]                      = "se.timeedit.net"
  request["Origin"]                    = "https://se.timeedit.net"
  request["Referer"]                   = "https://se.timeedit.net/web/chalmers/db1/b1/"
  request["Upgrade-Insecure-Requests"] = "1"
  request["User-Agent"]                = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.116 Safari/537.36"

  request.body = "authServer=student&username=#{cid}&password=#{password}&server=se_chalmers&database=t3_se_chalmers_01&fragment="

  # Use above data and request login at time-edit.
  response = http.request request

  # Parse out the auth-token from the set-cookie header and return it.
  cookie_header = response.header['set-cookie']
  cookie        = /TEwebchalmersdb1=(.*?);/.match cookie_header
  cookie[1] # First match group should be returned in order to only get cookie.
end

def book_room(auth_cookie, room, date, start_time, end_time)

  url = URI("https://se.timeedit.net/web/chalmers/db1/b1/ri1Q5008.html")

  http = HTTP.new(url.host, url.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  # Use above data and request login at time-edit.
  request = HTTP::Post.new(url)

  request["Accept"]           = "text/html, */*; q=0.01"
  request["Accept-Encoding"]  = "gzip, deflate"
  request["Accept-Language"]  = "sv-SE,sv;q=0.8,en-US;q=0.6,en;q=0.4,nb;q=0.2"
  request["Connection"]       = "keep-alive"
  request["Content-Length"]   = "207"
  request["Content-Type"]     = "application/x-www-form-urlencoded"
  request["Cookie"]           = "TEwebchalmersdb1=#{auth_cookie}"
  request["Host"]             = "se.timeedit.net"
  request["Origin"]           = "https://se.timeedit.net"
  request["Referer"]          = "https://se.timeedit.net/web/chalmers/db1/b1/ri1Q5008.html"
  request["X-Requested-With"] = "XMLHttpRequest"
  request["User-Agent"]       = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.116 Safari/537.36"

  request.body = "kind=reserve&nocache=4&l=sv_SE&o=204734.186&o=203460.192&aos=&dates=20160316&starttime=9%3A00&endtime=10%3A00&url=https%3A%2F%2Fse.timeedit.net%2Fweb%2Fchalmers%2Fdb1%2Fb1%2Fri1Q5008.html%2300204734&fe2=&fe8="
  puts "request: #{request.to_yaml}"
  response = http.request request
  puts "response: #{response.to_yaml}"
end

auth_cookie = login 'simpet', 'password'
book_response = book_room auth_cookie, nil, nil, nil, nil
# puts book_response.to_yaml
