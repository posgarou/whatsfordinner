require 'rubygems'
require 'bundler'

##########################
#          ENV           #
##########################

ENV['RACK_ENV'] ||= 'development'

# Gulp uses this to determine asset handling
ENV['NODE_ENV'] = ENV['RACK_ENV']

##########################
#        BUNDLER         #
##########################

Bundler.require(:defaults, ENV['RACK_ENV'].to_sym)

##########################
#        ASSETS          #
##########################

# In production, we should recompile the assets each time we rackup.
if ENV['RACK_ENV'] == 'production' && ENV['CASCADED'] != 'true'
  Process.spawn("cd #{File.dirname(__FILE__) } && gulp")
end

##########################
#          APP           #
##########################

class WFDinnerApp < Sinatra:: Base
  set :root, File.dirname(__FILE__)

  get '/' do
    # TODO: This really should be set up with a cache.  It looks very possible to set up a shared memcached between Sinatra and Gulp/Node: https://github.com/3rd-Eden/node-memcached and https://github.com/mperham/dalli

    # If there is a manifest file, it tells us where the current cached index.html is located.
    # Otherwise, we should load index.html
    send_file "#{File.dirname(__FILE__)}/public#{parsed_manifest_file["views/index.html"] || '/views/index.html'}"
  end

  # If /tmp/manifest.json exists, open and parse it. Otherwise, return {}.
  def parsed_manifest_file
    path = File.dirname(__FILE__) + '/tmp/manifest.json'
    (File.exists?(path) && JSON.parse(IO.read(path))) || {}
  end
end
