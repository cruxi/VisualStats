
require "travis"

# require all model files as they wouldn't be autoloaded if contained in travis-core
def require_all_rb (dir)
  config = Rails.configuration
  ruby_files = Dir["#{config.root}/#{dir}/*.rb"].map {|fn| File.basename(fn).gsub(/\.rb$/,"") }
  ruby_files.each {|r| require r}
end

require_all_rb "app/models"
