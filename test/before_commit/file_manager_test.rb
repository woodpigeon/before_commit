require 'test_helper'

module BeforeCommit
  class FileManagerTest < Minitest::Test
    def test_copy
      file = data_path('small.yml')
      target = data_path('temp.yml')
      assert !File.exists?(target), "File should not exist at #{target}"
      FileManager.copy file, target
      assert File.exists?(target), "File should exist at #{target}"
      File.delete target
    end
  end
end
