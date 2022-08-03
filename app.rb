require 'bundler/setup'

require 'sinatra'
require 'erb'

set :public_folder, 'public'


ENV['APP_ENV'] ||= 'development'

get "/" do
  erb :home
end

post '/upload' do
    tempfile = params[:file][:tempfile]
    filename = params[:file][:filename]
    cp(tempfile.path, "public/uploads/#{filename}")
    'File uploaded to public/uploads/'
end
