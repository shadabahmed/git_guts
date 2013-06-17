$:.unshift File.expand_path("../lib", __FILE__)
require 'git_server_app'
run GitServer::App
