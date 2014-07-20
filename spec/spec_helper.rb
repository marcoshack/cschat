require 'rubygems'
require 'bundler/setup'
require 'pry'

CSCHAT_DIR = File.dirname(File.absolute_path(File.join(__FILE__, '../')))
require File.join(CSCHAT_DIR, 'lib/cschat')
