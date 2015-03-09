# This Gemfile includes gems necessary for joining the two applications

gem 'rack'
gem 'rack-mount'

# Include the client and server gemfiles
CLIENT_GEMFILE_PATH = './client/Gemfile'
SERVER_GEMFILE_PATH = './server/Gemfile'

eval(IO.read(CLIENT_GEMFILE_PATH), binding)
eval(IO.read(SERVER_GEMFILE_PATH), binding)