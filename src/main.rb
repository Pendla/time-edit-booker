#!/usr/bin/env ruby

require './booker'
require './../config'

# Start of with dates 2 weeks from now, since those study rooms will
# pretty much always be free.
book_date = Time.now + 86400 * 13

# For every user that is specified, we want to book rooms.
TimeEditBooker::Config::USERS.each do |cid, password|
  # Login this user, so that we get an auth token for that session.
  auth_token = TimeEditBooker.login cid, password

  booked_days_counter = 0
  while booked_days_counter < 2
    # Morning
    morning_booked = TimeEditBooker.book_room auth_token,
                                              TimeEditBooker::Config::ROOM,
                                              book_date,
                                              TimeEditBooker::Config::MORNING_START_TIME,
                                              TimeEditBooker::Config::MORNING_END_TIME
    # Afternoon
    afternoon_booked = TimeEditBooker.book_room auth_token,
                                                TimeEditBooker::Config::ROOM,
                                                book_date,
                                                TimeEditBooker::Config::AFTERNOON_START_TIME,
                                                TimeEditBooker::Config::AFTERNOON_END_TIME

    # If the room was successfully booked, we can increase the counter.
    if morning_booked || afternoon_booked
      booked_days_counter = booked_days_counter + 1
      book_date = book_date + 86400
    end
  end
end
