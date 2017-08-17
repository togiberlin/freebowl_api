# FreeBowl API [![Travis CI Build Status](https://travis-ci.org/togiberlin/freebowl_api.svg?branch=master)](https://travis-ci.org/togiberlin/freebowl_api) [![Code Climate GPA Rating](https://codeclimate.com/github/togiberlin/freebowl_api/badges/gpa.svg)](https://codeclimate.com/github/togiberlin/freebowl_api) [![Codacy Rating](https://api.codacy.com/project/badge/Grade/9b3ce5e2992f41b4b54978a78b99361b)](https://www.codacy.com/app/togiberlin/freebowl_api?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=togiberlin/freebowl_api&amp;utm_campaign=Badge_Grade)
This programming problem is part of a private exercise.
This exercise is a good introduction and refresher to Rails API mode.

🎨📖 **API endpoint documentation:** [https://documenter.getpostman.com/view/2536067/freebowl_api/6n33Et5](https://documenter.getpostman.com/view/2536067/freebowl_api/6n33Et5)

## Project Justification
Why this project? And what is an API, explained in simple and plain English?

API stands for [application programming interface](https://en.wikipedia.org/wiki/Web_API). It allows any type of app (from e.g. smartphones, tablets, laptops, desktops etc.) to connect to a database via the internet, and do the following stuff:

- retrieve data (e.g. text, images, videos etc.)
- store data
- manipulate data (e.g. updating text, status posts)
- delete data (e.g. deleting status posts)

Besides these four basic cases, the API can also do more complex stuff, like e.g. video processing, image transformation and much, much more. In this project, we calculate the scores of a bowling game. We submit the number of knocked down pins, and the API will provide us with accurate score numbers.

The cool thing about APIs is, that it allows you to create an ecosystem, where other 3rd party apps can dock on and create value. For example, Facebook APIs allow app developers to implement a "login with Facebook" feature, which keeps user login (and password!) hassle minimal. Thanks to PayPal APIs, users are able to conveniently make international payments with a few clicks. Compare that to the traditional MoneyGram or Western Union approach.

> APIs are like doors between walled gardens.

In short: APIs are interesting, fun, extremely relevant and the hidden, main driving force (or _glue_) behind the web 2.0.

## Project Task
Build a Ruby on Rails API that takes score of a bowling game.
You have the freedom to define the architecture of the API and how its endpoints will look.

### Main Requirements
The API should be written using Ruby on Rails. In addition, it should provide the following:

* A way to start a new bowling game; ✅ **DONE** 🙃
* A way to input the number of pins knocked down by each ball; ✅ **DONE** 😝
* A way to output the current game score (score for each frame and total score). ✅ **DONE** 🤓

Imagine that this API will be used by a bowling house. On the screen the user starts the game, then
after each throw the machine, with a sensor, counts how many pins were dropped and calls the API
sending this information. In the meantime the screen is constantly (for example: every 2 seconds)
asking the API for the current game status and displays it.

### Logic Details
* Bowling is played by throwing a ball down a narrow alley toward ten wooden pins. The objective is to knock down as many pins as possible per throw.
* The game is played in ten frames. At the beginning of each frame, all ten pins are set up. The player then gets two tries to knock them all down.
* If the player knocks all the pins down on the first try, it is called a "strike,“ and the frame ends.
* If the player fails to knock down all the pins with his first ball, but succeeds with the second ball, it is called a "spare“.
* After the second ball of the frame, the frame ends even if there are still pins standing.
* A strike frame is scored by adding ten, plus the number of pins knocked down by the next two balls, to the score of the previous frame.
* A spare frame is scored by adding ten, plus the number of pins knocked down by the next ball, to the score of the previous frame.
* Otherwise, a frame is scored by adding the number of pins knocked down by the two balls in the frame to the score of the previous frame.
* If a strike is thrown in the tenth frame, then the player may throw two more balls to complete the score of the strike.
* Likewise, if a spare is thrown in the tenth frame, the player may throw one more ball to complete the score of the spare.
* Thus the tenth frame may have three balls instead of two.

For background information, please see [Wikipedia](http://en.wikipedia.org/wiki/Ten-pin_bowling)

## Setup
* Make sure [Ruby](https://www.ruby-lang.org/en/documentation/installation/) is installed. As of August 2017, Ruby version 2.4.1 is recommended.
* Make sure you have a Ruby version manager, like e.g. [rbenv](https://github.com/rbenv/rbenv). Alternatively, pick [RVM](https://rvm.io/).
* Make sure you have Bundler installed. If not, run ```$ gem install bundler```.
* Run ```$ bundle install``` to install all dependencies, including Rails 5.1.3. Note: Rails runs in **API mode**, so there are no views.
* Run ```$ rake db:create db:migrate``` to create the database, run all migrations.
* _Optional_: to populate the db with example data, run ```$ rake db:seed```.
* To start Rails, run ```$ rails s```.

## Testing APIs and API Documentation
* Run ```$ rake routes``` to see all GET, POST, PUT and DELETE HTTP-routes.
* _Optional_: To run all RSpec tests, enter ```$ rspec```. This is however not really necessary, as [Travis](https://travis-ci.org/togiberlin/freebowl_api) does this automatically.
* Install [Postman](https://www.getpostman.com/) to start testing the APIs. Alternatively, you can use [HTTPie](https://httpie.org/) inside the command line.
* Watch the Postman API documentation here: [https://documenter.getpostman.com/view/2536067/freebowl_api/6n33Et5](https://documenter.getpostman.com/view/2536067/freebowl_api/6n33Et5)
* You can conveniently import all endpoints from here: [https://www.getpostman.com/collections/ac79b8d279b27bc4f725](https://www.getpostman.com/collections/ac79b8d279b27bc4f725). For importing, click on ```File```, ```Import...```, ```Import from link```.
* After successful import, make sure to set the ```url``` environment key to value: ```localhost:3000```. You are ready to go!

## The Bowling Workflow
This section explains, how the client will retrieve, insert, modify and delete data records.

### Setting up a Game
* To start a game, call this **POST** endpoint: ```localhost:3000/api/v1/games?created_by=Cashier 3: Daenerys Targaryen```. It will create a game with ```id: 1```, if database was empty before.
* To create the first player, call this **POST** endpoint: ```localhost:3000/api/v1/games/1/players?name=Khal Drogo```. It will create a player with ```id: 1```, if database was empty before.
* To create the second player, call this **POST** endpoint again: ```localhost:3000/api/v1/games/1/players?name=John Snow```. It will create a player with ```id: 2```, if database was empty before.

### Displaying the Entire Scoreboard
* To check results, call this **GET** endpoint: ```localhost:3000/api/v1/games/1```. This endpoint is used to display the **entire** scoreboard (current game including all players, all frames, all scores).

This endpoint displays everything, so that the frontend client doesn't have to call countless APIs and painstakingly glue data together. If you followed all steps until now, there should be one game and two players, however no frames. In the next step, we are going to create and update frames.

### Inserting Data
#### Player One
* First, we need to create the first frame of the first player. We do this by calling this **POST** endpoint: ```localhost:3000/api/v1/games/1/players/1/frames```. Notice, that no parameters are passed.
* You can modify data with this **PUT** endpoint: ```localhost:3000/api/v1/games/1/players/1/frames/1?ball_one_pins=7&ball_two_pins=3```.
* *__Optional__: to do the first two steps in one go, use this __POST__ request instead: ```localhost:3000/api/v1/games/1/players/1/frames?ball_one_pins=6&ball_two_pins=3```.*
* For subsequent frames, repeat the steps.
* At frame 10, the game ends. The API won't allow more than 10 frames.

#### Player Two
* First, we need to create the first frame of the second player. We do this by calling this **POST** endpoint: ```localhost:3000/api/v1/games/1/players/2/frames```. Notice, that no parameters are passed.
* You can modify data with this **PUT** endpoint: ```localhost:3000/api/v1/games/1/players/2/frames/1?ball_one_pins=7&ball_two_pins=3```.
* *__Optional__: to do the first two steps in one go, use this __POST__ request instead: ```localhost:3000/api/v1/games/1/players/2/frames?ball_one_pins=6&ball_two_pins=3```.*
* For subsequent frames, repeat the steps.
* At frame 10, the game ends. The API won't allow more than 10 frames.
