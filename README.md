# README

This is a bucketlist API built using Ruby on Rails and a Postgres database. 

Here is a list of the available endpoints:

| Endpoint                                             |Description                                 |
| -----------------------------------------------------|-------------------------------------------:|
|POST /users                                           |Create a new user                           |
|POST /auth/login                                      |Logs a user in                              |
|POST users/<user_id>/buckets/                         |Create a new bucket list                    |
|GET users/<user_id>/buckets/                          |List all the created bucket lists           |
|GET users/<user_id>/buckets/<bucket_id>               |Get single bucket list                      |
|PUT users/<user_id>/buckets/<bucket_id>               |Update this bucket list                     |
|DELETE users/<user_id>/buckets/<bucket_id>            |Delete this single bucket list              |
|POST users/<user_id>/buckets/<bucket_id>/items/       |Create a new item in bucket list            |   
|GET users/<user_id>/buckets/<bucket_id>/items         |List all the created items in a bucket list |
|GET users/<user_id>/buckets/<bucket_id>/items/<id>    |Get a single item in a bucket list          |    
|PUT users/<user_id>/buckets/<bucket_id>/items/<id>    |Update a bucket list item                   |
|DELETE users/<user_id>/buckets/<bucket_id>/items/<id> |Delete an item in a bucket list             |


## Getting started with the API locally
### Application requirements
Before you can run the application, the following items need to be installed.
- [Ruby](https://www.ruby-lang.org/en/)
- [Rails 5.0](https://rubygems.org/gems/rails/versions/5.0.0.1)
- [RSpec](https://rubygems.org/gems/rspec/versions/3.4.0)
- [Bundler](https://rubygems.org/gems/bundler)
- [Postgresql](https://www.postgresql.org/)

### Clone the repository
`git clone https://github.com/andela-rwachira/bucketlist-api.git`
### Install dependencies
`bundle install`
### Setup the database
`rails db:setup`
### Run the server
`rails s`
### Run tests
`bundle exec rspec`