# Source: http://funonrails.com/2014/03/building-restful-api-using-grape-in-rails/
namespace :api do
  desc "API Routes"
  task :routes => :environment do
    WhatsForDinner::API.routes.each do |api|
      method = api.route_method.ljust(10)
      path = api.route_path.gsub(":version", api.route_version)
      puts "     #{method} #{path}"
    end
  end
end