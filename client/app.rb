require 'rubygems'
require 'bundler'

Bundler.require(:defaults)

class WFDinnerApp < Sinatra:: Base
  set :root, File.dirname(__FILE__)

  get '/' do
    send_file './client/public/views/index.html'
  end
end