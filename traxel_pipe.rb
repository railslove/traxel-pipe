require 'compass'
require 'sinatra'
require 'pusher'
require 'json'
require 'haml'
require 'coffee_script'


configure :development do
  require 'sinatra/reloader'
  require File.join(Sinatra::Application.root, 'config', 'pusher_development_config.rb')
end

configure do
  Compass.add_project_configuration(File.join(Sinatra::Application.root, 'config', 'compass.config'))
end

# at a minimum, the main sass file must reside within the ./views directory. here, we create a ./views/stylesheets directory where all of the sass files can safely reside.
get '/stylesheets/:name.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass(:"stylesheets/#{params[:name]}", Compass.sass_engine_options )
end

get '/' do
  haml :index
end

get '/application.js' do
  coffee :application
end

get '/ping' do
  return_hash = request.env.to_hash.merge(request.params.to_hash)
  Pusher['test_channel'].trigger('ping', return_hash.to_json)
end