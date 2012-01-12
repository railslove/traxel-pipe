require 'sinatra'

get '/' do
  haml :index
end

get '/ping' do
  Pusher['test_channel'].trigger('greet', {
    :greeting => "Hello there!"
  })
end