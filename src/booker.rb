require 'net/http'
require 'yaml'
require 'openssl'

require './../config'

module TimeEditBooker
  include Net

  CONTENT_TYPE = "application/x-www-form-urlencoded"
  USER_AGENT   = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.116 Safari/537.36"

  public
  ##
  # Helper method that is used to login to time edit. It takes a CID and the
  # password associated with it and returns the Cookie that should be sent to
  # time edit for authing further requests.
  def TimeEditBooker.login(cid, password)
    url = URI(TimeEditBooker::Config::LOGIN_URL)

    http = HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = HTTP::Post.new(url)

    request["Content-Type"] = CONTENT_TYPE
    request["User-Agent"] = USER_AGENT

    request.body = "authServer=student&username=#{cid}&password=#{password}&server=se_chalmers&database=t3_se_chalmers_01&fragment="

    # Use above data and request login at time-edit.
    response = http.request request

    # Parse out the auth-token from the set-cookie header and return it.
    cookie_header = response.header['set-cookie']
    cookie        = /TEwebchalmersdb1=(.*?);/.match cookie_header
    cookie[1] # First match group should be returned in order to only get cookie.
  end

  ##
  # Helper method that is used to book the specified room, at the specified
  # date between the specified times.
  # TODO If room booking failed, return false otherwise true.
  # TODO Specify room as room name instead of data-id found in page source.
  def TimeEditBooker.book_room(auth_cookie, room, date, start_time, end_time)

    parsed_date  = date.strftime("%Y%m%d")
    parsed_start = start_time.strftime("%H:%M")
    parsed_end   = end_time.strftime("%H:%M")
    # Construct a HTTP object that we can use to send requests to time edit.
    url = URI(TimeEditBooker::Config::BOOK_URL)
    http = HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    # Construct a request to send to time edit.
    request = HTTP::Post.new(url)
    request["Content-Type"] = CONTENT_TYPE
    request["User-Agent"] = USER_AGENT
    # Tell time edit which user we are currently logged in as.
    request["Cookie"] = "TEwebchalmersdb1=#{auth_cookie}"
    request.body = "kind=reserve&nocache=4&l=sv_SE&o=#{room}&o=203460.192&aos=&dates=#{parsed_date}&starttime=#{parsed_start}&endtime=#{parsed_end}&url=https%3A%2F%2Fse.timeedit.net%2Fweb%2Fchalmers%2Fdb1%2Fb1%2Fri1Q5008.html&fe2=&fe8="

    # Now send the request to time edit.
    response = http.request request

    # TODO Only respond true if room was successfully booked
    true
  end
end
