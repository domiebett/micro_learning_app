[![Build Status](https://travis-ci.org/domiebett/micro_learning_app.svg?branch=develop)](https://travis-ci.org/domiebett/micro_learning_app)    [![Coverage Status](https://coveralls.io/repos/github/domiebett/micro_learning_app/badge.svg?branch=develop)](https://coveralls.io/github/domiebett/micro_learning_app?branch=develop)

# Micro Learning App
This is a Sinatra application designed to send a user a page daily on a topic they would love to learn. It helps users learn in a step by step design with daily relevant posts to help them build up their knowledge on topics.

## Set up.
To set up this application on your local environment, you need to have [ruby](https://www.ruby-lang.org/en/documentation/installation/) installed.

You also need to have [postgres](http://www.postgresqltutorial.com/install-postgresql/) installed as the project uses it to save data locally. You could also use your preferred database with minor changes to the `config/database.yml` file present in the project.

## Project set up
### Clone project.
On your terminal run:
> `$ git clone `[`https://github.com/domiebett/micro_learning_app.git`](https://github.com/domiebett/micro_learning_app.git)

Checkout to project root folder.
> `$ cd micro_learning_app`

### Install packages.
On your terminal run:
> `$ bundle install`

### Set up database
Create database
> `$ bundle exec rake db:create`

Migrate to the database
> `$ bundle exec rake db:migrate`

To seed initial data
> `$ bundle exec rake db:seed`

### Run application
> `$ thin -R config.ru start`

However if you dont have thin server installed globally,
> `$ bundle exec thin -R config.ru start`

### Open application
Go to your browser and enter the url `http://localhost:3000`

## Testing application

### Set up test database
> `$ bundle exec rake db:test:prepare`

To run tests for the application

> `$ bundle exec rspec`

## Author
[Dominic Bett](https://github.com/domiebett)
