require 'bundler/setup'

require 'sinatra'
require 'erb'
require 'mail'
require 'fileutils'

set :public_folder, 'public'


ENV['APP_ENV'] ||= 'development'

get "/" do
  erb :home
end

post '/upload' do
  tempfile = params[:file][:tempfile]
  mail = Mail.read(tempfile.path)
  html = ''
  success = true
  begin
    html = mail.decoded
  rescue
    success = false
  end

  if html.length == 0
    success = false
  end

  if !success
    redirect '/failure'
  end

  headers['Content-Disposition'] = "attachment;filename=good_html_file.html"
  mail.decoded
end

get '/failure' do
  erb :failure
end
