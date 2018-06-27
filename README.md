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
> `$ rake Gemfile`

### Run application
> `$ thin -R config.ru start`

### Open application
Go to your browser and enter the url `http://localhost:3000`

## Author
[Dominic Bett](https://github.com/domiebett)
