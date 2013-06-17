require 'bundler'
require 'git'

module GitGuts
  class Server < Thor::GitGroup
    WORKING_DIRECTORY = Dir.getwd
    desc 'Starts a local git server'
    class_option :port, :aliases => '-p', :required => true, :type => :numeric
    def start
      begin
        Git.open(WORKING_DIRECTORY)
        ENV['RACK_ENV'] = 'production'
        ENV['GIT_DIR'] = WORKING_DIRECTORY
        ENV['BUNDLE_GEMFILE'] = File.expand_path('../../git_server/Gemfile', __FILE__)
        require 'git_server/lib/git_server_app'
        Rack::Server.start :app => GitServer::App, :Port => options[:port]
      rescue ArgumentError => e
        puts "Could not start server. Is it a valid git repository ?"
      else
        puts "Server closed"
      end
    end
  end
end
