# ruby-api
This is a simple api written in ruby using Sinatra as a web framework.
It includes a simple api for adding new users and getting information about existing users
via the `/users/` route.

It also uses DataMapper to host an in memory sqlite database for storing the users.

# Usage

Clone the repository via `git clone`.

Run `bundle` in your terminal

To start the server use `rackup` it will be available per default at `localhost:9292`

To run the test run `ruby tests.rb` in your terminal
