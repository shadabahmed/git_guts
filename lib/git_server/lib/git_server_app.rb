require_relative 'version'
require 'tempfile'
require 'base64'
require_relative 'git_server'

module GitServer

  class App
    configure do
      set :root, File.join(File.dirname(__FILE__), '..')
      set :public_folder, File.join(root, 'public')
      set :views, File.join(root, 'views')
      set :environment, :production
      disable :logging, :sessions
    end
  end

  class Repository < Rack::Directory
    def self.path
      GitRepo.repo.path
    end

    def self.url
      "/#{File.basename GitRepo.dir.path}.git"
    end

    def initialize
      super(self.class.path)
    end
  end
end

GitServerApp = Rack::URLMap.new('/' => GitServer::App.new,
                                GitServer::Repository.url => GitServer::Repository.new)
