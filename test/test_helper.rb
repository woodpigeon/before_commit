$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'before_commit'

require 'minitest/autorun'

class Minitest::Test
  
  def data_file(path)
    File.read data_path(path)
  end
  
  def data_path(path)
    File.expand_path(path, data_root)
  end
  
  def data_root
    File.expand_path('data', File.dirname(__FILE__))
  end
  
  def config_file_path
    data_path('config.yml')
  end
  
end
