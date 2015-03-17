# Source: http://funonrails.com/2014/03/building-restful-api-using-grape-in-rails/
namespace :api do
  desc "API Routes"
  task :routes => :environment do
    API::Root.routes.each do |api|
      method = api.route_method.ljust(10)
      # path = api.route_path.gsub(":version", api.route_version)
      path = api.route_path
      puts "     #{method} #{path}"
    end
  end
end
