require 'sinatra'

get '/' do
  haml :index
end

get '/ping' do
  "Hello World!"
end