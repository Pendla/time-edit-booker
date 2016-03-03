# TimeEdit Study room booker
This is a utility script that sends requests to the TimeEdit system for Chalmers University of Technology in order to book a study room.

## Setup
1. Rename `config.rb.example` -> `config.rb`
2. Modify the list of cids with your list of cids and passwords that should be used to book rooms
3. Modify the times you want to book the room
4. Modify the room that you want to book*

\* The room id number can be found by manually browsing the source code for TimeEdit (See TODO for fix). The example config uses M1212D, if you browse TimeEdit for this room you can see for yourself where to look for the room id.

## TODO
* Sort the users by the number of available bookings they have and book a room with them in that order.
* Add crawler for time edit and construct a map `room names -> room id`.

I will gladly consider any pull requests submitted. If you have any questions, feel free to contact me. Email available through my profile here at github (Pendla).

## Disclaimer
I do not take any responsibility in which way this is used. This was developed solely for educational purposes. I DO NOT recommend using
this in any way that compromises the system for other students at the university.
