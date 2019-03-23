# README

* Simple twilio application text messanging
* Requires setting webhook in twilio console to the appropriate URL. ```http://host.com/incoming_text```
* Configure appropriate settings in .env (See dotenv-example for example)
* You can use ngrok to connect to the local rails server from the twilio console.

## Setup

```
bundle install
bundle exec rake db:migrate
copy dotenv-example to .env and modify accordingly
rails server
ngrok http 3000 # new terminal
setup appropriate URL in Twilio webhook.
```
