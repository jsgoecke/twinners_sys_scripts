#!/usr/bin/env ruby
require 'rubygems'
require 'git'

required_gems = [
  { :name => 'stompserver'},
  { :name => 'git'}
  ]
  
git_repos = [
  
  { :location => 'git@github.com:jicksta/twinners.git', :name => 'twinners' },
  { :location => 'git@github.com:jicksta/stomptomanagerbridge.git', :name => 'stomptomanagerbridge' },
  { :location => 'git://github.com/jicksta/adhearsion.git', :name => 'adhearsion'}
  ]

case ARGV.first
when 'install'
  #First install the required gems
  required_gems.each do |install_gem|
    system "sudo gem install #{install_gem[:name]}"
  end
  #Install the repos
  git_repos.each do |repo|
    Git.clone(repo[:location], repo[:name])
    puts "Cloned #{repo[:name]} from #{repo[:location]}"
  end
when 'upgrade'
  git_repos.each do |repo|
    Git.pull(repo[:location], repo[:name])
    puts "Updated #{repo[:name]} from #{repo[:location]}"
  end
end

unless %w{install upgrade}.include? ARGV.first
  puts "Usage: deploy.rb {install|upgrade}"
  exit
end