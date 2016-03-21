require 'before_commit/version'
require 'before_commit/file_manager'
require 'before_commit/runner'
require 'before_commit/command'
require 'before_commit/config'
require 'before_commit/check'

require 'before_commit/railtie' if defined?(Rails)

module BeforeCommit
  
end
