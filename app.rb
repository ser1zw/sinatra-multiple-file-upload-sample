require 'sinatra'

set :bind, '0.0.0.0'
set :storage_path, File.dirname(__FILE__) + '/uploaded_files'

get '/' do
  files = Dir.glob("*", base: settings.storage_path)
  erb :index, locals: { files: files }
end

get '/download/:filename' do
  filename = params['filename']
  send_file "#{settings.storage_path}/#{filename}"
end

post '/store' do
  params['files'].each { |file|
    filename = file['filename']
    open("#{settings.storage_path}/#{filename}", 'wb') { |f|
      data = file['tempfile'].read
      f.write data
    }
  }
  redirect '/'
end
