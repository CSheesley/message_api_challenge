# README

## DESCRIPTION
This is a code challenge project, in which a small **Messaging API** was created. This is a working proof of concept which showcases how `Messages` with `:recipient`, `:sender`, and `:body` information can be created and gathered from API endpoints. The full challenge description can be found [here](/code_challenge_description.pdf).

Due to time-boxing and the scope of the challenge, things such as Authentication and Registration were skipped _(skipping the creation of or reference to 'Users' objects all together)_.

```
Ignore Authorization, Authentication and Registration.
Assume this is a global api that can be leveraged by anyone,
security is not a concern.
```

Please see the **DESIGN DECISIONS AND INSIGHTS** section at the bottom for more information on thoughts and decisions that were made along the way.

My **areas of emphasis** during this project were:
- Creating functional API endpoints which meet the acceptance criteria of the challenge.
- Following good MVC principles.
- Adequately testing models, requests, and services.
- Demonstrating proper git workflow practices - _(clean and ligical commit history, squashing when necessary)_
- Providing good documentation for those who take a look at this project.


## API DOCUMENTATION
This project provides a single API endpoint where Message objects can be created or accessed, via GET and PUT requests with the necessary params: `/api/v1/messages`

Please see the [API Endpoint Documentation](/endpoint_documentation.md) for specific details.

Tools such as [Postman]()

## SETUP

### Clone Repository
From your terminal, navigate to the directory that you would like to clone this project into. Once there, run one of the following commands:
```
Using SSH:
$ git clone git@github.com:CSheesley/message_api_challenge.git

Using HTTPS:
$ git clone https://github.com/CSheesley/message_api_challenge.git
```

You can run the following commands from within any directory on your machine - however for the sake of this setup, we can better scope configuration changes to just this repository. From the command line, navigate to be inside the project directory.
```
$ cd message_api_challenge
```

### Versions
- **Ruby 2.5.1**
- **Rails 5.2.4**
- **Bundler 2.2.1**

###### Installing Ruby.
First check to see if you currently have this version installed by running `$ rbenv versions`. This will list all of the ruby versions you have available.
- If version **2.5.1** is listed, skip the following 'install' step.
- If version **2.5.1** is not listed, run the command `$ rbenv install 2.5.1`, which will run the install, _which does take a few minutes_.
- Once you have version **2.5.1** available, you can set that as the local version for any repo by running the command `$ rbenv local 2.5.1`.

###### Installing Rails.
From within the project, run the following command to install this version of rails for this repository.
```
$ gem install rails -v 5.2.4
```
_*Note, it is not entirely necessary to install rails at this level, as it will be installed for the project via the Gemfile here shortly - however having it as a local gem will give us access to command line 'rails' commands such as '$rails c' and '$rails s'_

###### Installing Bundler.
To install Bundler, run the following command: `$gem install bundler`. Confirm that this installed correctly by running: `$ bundler -v`, which should output "Bundler version 2.2.10".

Bundler can sometimes be tricky to set up and configure, especially if you already have another version running. There are plenty of resources on the internet to help get your machine point at and using a specific Bundler version - however if this is a hassle for this project, don't worry - as long as you have _any_ version of Bundler, we can make things work with a work around to come.

### INSTALLING GEMS
Once you have your versions of Ruby and Bundler ready to go, its time to install the GEMS for this project. Make sure that you are in the project by running `$ pwd` from the command line. If you are not currently in the `/message_api_challenge` directory, now is a great time to get there.

Once there, run: `$ bundle install` which will install our GEM libraries and dependecies.
_If you get an bundling error and the previous command was not successful, AND your bundler version is not 2.2.1, then we can try removing that dependency. NOTE: This is not a proper solution for production code - but for the sake of time and hassle for anyone reviewing this code challenge, the following work around is avaialble._

Open the `Gemfile.lock` file, and remove the two lines at the bottom which read:
```
BUNDLED WITH
   2.2.10
```
Once deleted, run `$ bundle install` again, and cross your fingers.


### DATABASE

Run the following commands to create and setup our database:  
`$ rake db:create`  
`$ rake db:schema:load`  
`$ rake db:seed` _(see the `seeds.rb` file for the sample data that we are creating)_

_Note: If for some reason the 'rake' command does not work - try swapping that out with 'rails', if you installed Rails locally_


### START YOUR LOCAL SERVER
In order to hit our endpoint locally, you will need to start our local server. To do so open up a new tab in your terminal, make sure that you are in the project directory, and then run:
```
$ rails server
```

This will allow to hit our Messaging API base endpoint.
```
http://localhost:3000/api/v1/messages
```

You can shut down the server at any point by entering: `Ctrl-C` from the command line in the tab where the server is running.


## TESTING
This project uses `RSpec` for running our tests - in this case wich are comprised of the `model` and `request` variety. To run the full test suite, run one of the following commands:
```
$ rspec

$ bundle exec rspec
```
To check our overall test coverage, you can open up a Test Coverage HTML page _(courtesy of `SimpleCov`)_ by running the following command in the this command from inside the terminal: `$ open coverage/index.html`
 _Spoiler alert - its at 100%._


## DESIGN DECISIONS AND INSIGHTS
* Would do
 - use User objects, with joins
 snippet from other rep
  - ReceivedMessagesController
  - SentMessagesController
 - sanitize params more thoroughly to avoid dangerous data
 - link failed responses to published API docs html
 - add CI
 - param input validations

 - work done on single 'main' branch. Normal workflow would be using feature_branches during the development lifecycl
 - good commit history
