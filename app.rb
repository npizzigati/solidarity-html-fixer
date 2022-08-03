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
    # filename = params[:file][:filename]
    upload_path = "public/uploads/upload.eml"
    FileUtils.cp(tempfile.path, upload_path)
    mail = Mail.read(upload_path)

    headers['Content-Disposition'] = "attachment;filename=good_html_file.html"
    mail.decoded
end
