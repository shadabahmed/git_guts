$:.unshift File.expand_path("../lib", __FILE__)
Bundler.require
require 'git_server_app'
run GitServer::App
