# Ember CLI && Torii && Ember Simple Auth && Rails

This example app allows users authenticate using their GitHub
account. Their GitHub information is used to create an account on the Rails
server along with an access token.

This app makes use of:

* [Ember CLI][1]
* [Rails 4.1][2]
* [Ember Simple Auth][3]
* [Torii][4]

## Demo

There's a demo of this app running at
[https://ember-cli-rails-auth.firebaseapp.com/](https://ember-cli-rails-auth.firebaseapp.com/).

## How it Works

1. [Torii][4] is used to fetch a temporary authorization code from GitHub as
   described in [GitHub's Web Application Flow docs][5].
2. [Ember Simple Auth][3] uses the temporary authorization code to authenticate
   the session with the Rails server.
3. The Rails server uses the temporary authorization code to fetch the
   associated accounts details, find or create a matching user, and then find or
   create an access token for that user.
4. The Rails server sends the matching user's access token back to [Ember Simple
   Auth][3] on the client side along with the current user's id.
5. [Ember Simple Auth][3] stores the access token and current user's id in local
   storage.
6. [Ember Simple Auth][3] fetches the current user's record from the server and
   adds it to the store.
7. [Ember Simple Auth][3] uses the stored access token to authorize further
   requests that are sent to the server.

## Installation

1. Clone this repo.
2. Edit the api keys in `frontend/config/environment.js` (you'll need to
   register your application with GitHub).
3. Copy `backend/.env.sample` to `backend/.env` and add your GitHub credentials.
4. Start both apps with `rake run`.

[1]: https://github.com/stefanpenner/ember-cli  "Ember CLI"
[2]: http://rubyonrails.org/  "Ruby on Rails"
[3]: https://github.com/simplabs/ember-simple-auth  "Ember Simple Auth"
[4]: https://github.com/Vestorly/torii  "Torii"
[5]: https://developer.github.com/v3/oauth/#web-application-flow  "GitHub Web Application Flow docs"
