# TimeEdit Study room booker
This is a utility script that sends requests to the TimeEdit system for
Chalmers University of Technology in order to book a study room.

## Setup
1. Rename `config.rb.example` -> `config.rb`
2. Modify the list of cids with your list of cids and passwords that should be used to book rooms
3. Modify the times you want to book the room
4. Modify the room that you want to book*

\* The room id number can be found by manually browsing the source code for TimeEdit. The example config uses M1212D, if you browse TimeEdit for this room you can see for yourself where to look for the room id.

## Features
* Book rooms at Chalmers starting at a specific date and forward using a list of student-accounts.

### Coming
* Room priority list, such that if booking with room 1 fails retry with room 2, then room 3...
* Try another user, if the currently logged in one have used all its rooms.
* Prioritize booking rooms with the user that has the most rooms available
* Book specific dates
* Map over `room name -> room id`

## Want to contribute?
Make a pull request and I will gladly consider it. If you have any questions,
feel free to contact me.

## Disclaimer
I do not take any responsibility in which way this is used. This was developed
solely for learning purposes. I DO NOT recommend using this in any way that
will compromise the system for other students at the university or similar.
