require 'rack'
require 'git'
require 'sinatra'
require 'haml'
require 'git'
require 'filemagic'
require 'diffy'
require 'thin'

module GitGuts
  class Server < Thor::GitGroup
    desc 'Starts a local git server'
    class_option :port, :aliases => '-p', :required => true, :type => :numeric
    class_option :dir, :aliases => '-d', :required => false, :type => :string, :desc => 'Repository directory . Default is current directory'
    def start
      repo_dir = (options[:dir] && File.expand_path(options[:dir])) || Dir.getwd
      puts repo_dir
      begin
        options[:dir] ? Git.bare(repo_dir) : Git.open(repo_dir)
        ENV['RACK_ENV'] = 'production'
        ENV['GIT_DIR'] = repo_dir
        ENV['BARE'] = '1' if options[:dir]
        require 'git_server/lib/git_server_app'
        Rack::Server.start :app => GitServerApp, :Port => options[:port]
      rescue ArgumentError
        puts "Could not start server. Is it a valid git repository ?"
      else
        puts "Server closed"
      end
    end
  end
end

