require 'sinatra'

get '/' do
  haml :index
end

get '/application.js' do
  coffee :application
end

get '/ping' do
  Pusher['test_channel'].trigger('greet', {
    :greeting => "Hello there!"
  })
end