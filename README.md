# README

Using:
1.
Clean JSON generation with JBuilder
http://localhost:3000/photos.json
http://localhost:3000/photos/3.json
Jbuilder gives you a simple DSL for declaring JSON structures that beats manipulating giant hash structures. This is particularly helpful when the generation process is fraught with conditionals and loops.
Deliver JSON through your API
Separate the presentation concern from the model
Control what goes in your JSON



This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

To do:
1.Analyzing Files 
https://evilmartians.com/chronicles/rails-5-2-active-storage-and-beyond
Active Storage analyzes files once they've been uploaded by queuing a job in Active Job. Analyzed files will store additional information in the metadata hash, including analyzed: true. You can check whether a blob has been analyzed by calling analyzed? on it.
Image analysis provides width and height attributes. Video analysis provides these, as well as duration, angle, and display_aspect_ratio.
Analysis requires the mini_magick gem.

CarrierWave
https://github.com/carrierwaveuploader/carrierwave
This gem provides a simple and extremely flexible way to upload files from Ruby applications. It works well with Rack based web applications, such as Ruby on Rails.

2. Amazon S3

3. Upload speed up N+1 queries
https://stackoverflow.com/questions/27316190/how-to-speed-up-image-uploading-carrierwave-and-rails4
if you're uploading big files, it's likely your local network's upload speed that is the bottleneck.

4. handle huge mount of uploading
increased the pool size in database.yml from 5 to 7
puma could not obtain a connection from the pool within 5.000 seconds (waited 5.217 seconds); all pooled connections were in use

5.Added file size and content type validations to ActiveModel
gem 'file_validators'