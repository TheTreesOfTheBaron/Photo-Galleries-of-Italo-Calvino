# README

An in progress online store for artists to sell their works about the renowned Italian fiction writer Italo Calvino.
Built with Ruby on Rails.

A user will have the permission to show, edit, and destroy their own photos, 
but only have the permission to show when the photos were created by others and are publicly visible.

## Features

### SEARCH function (To be added)
from characteristics of the images

from text

from an image (search for similar images)
    
### ADD image(s) to the repository (Partially Done)
one / bulk / enormous amount of images (Done) 

private or public (permissions) (Done)

secure uploading and stored images (To be added)
    
### DELETE image(s) (Done)
one / bulk / selected / all image

Prevent a user deleting images from another user (access control)

secure deletion of images

### SELL/BUY images (To be added)
ability to manage inventory

set price

discounts

handle money


## Requirements

Ruby 2.7.1

Rails 6.0.3.2

Bundler 2.1.4


## Technologies

**Store photos**

Active Storage

**Build JSON APIs.**

gem 'jbuilder', '~> 2.7'

**Use Active Storage variant**

gem 'image_processing', '~> 1.2'

**Devise is a flexible authentication solution for Rails based on Warden**

gem 'devise'

**Add file size and content type validations to ActiveModel**

gem 'file_validators'

**Simple to check and uncheck checkboxes**

gem 'select_all-rails'

**Use S3**

gem "aws-sdk-s3", require: false

**Add testing**

gem 'rspec-rails'

**To upload code to production**

gem 'capistrano', '~> 3.11'

gem 'capistrano-rails', '~> 1.4'

gem 'capistrano-passenger', '~> 0.2.0'

gem 'capistrano-rbenv', '~> 2.1', '>= 2.1.4'


## Running the app

Clone the repo to your local machine: git clone RepoURL

Install dependencies: bundle install

Migrate the database: rails db:migrate

Seed the database: rails db:seed

Run the server: rails server

Open the URL in your browser: http://localhost:3000