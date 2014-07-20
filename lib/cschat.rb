
module Cschat
  module Action; end
end

CSCHAT_LIB_DIR = File.join(File.dirname(File.absolute_path(__FILE__)), 'cschat')
Dir["#{CSCHAT_LIB_DIR}/*.rb"].each { |f| require f }
