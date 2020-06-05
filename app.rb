require 'sinatra'

set :bind, '0.0.0.0'
set :storage_path, File.dirname(__FILE__) + '/uploaded_files'

get '/' do
  erb :index
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
