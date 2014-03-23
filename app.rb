require 'sinatra'

get '/' do
  haml :index
end

get '/:page.html' do
end
