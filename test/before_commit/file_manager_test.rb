require 'test_helper'

module BeforeCommit
  class FileManagerTest < Minitest::Test    
    
    def teardown
      File.delete(target) if File.exist? target
      FileUtils.rm_rf current if Dir.exist? current
    end
    
    def test_copy
      assert !File.exists?(target), "File should not exist at #{target}"
      FileManager.copy source, target
      assert File.exists?(target), "File should exist at #{target}"
    end
    
    def test_copy_to_new_subfolder
      @target = data_path('foo/temp.yml')
      test_copy
      FileUtils.rm_rf File.dirname(target)
    end
    
    def test_copy_replaces_existing
      content = 'Foo Bar'      
      File.write target, content
      assert_equal content, target_content
      FileManager.copy source, target
      refute_equal content, target_content
      assert_equal source_content, target_content
    end
    
    def test_copy_dir_to_current
      make_current_working_directory
      FileManager.copy_dir_to_current dir
      ['foo', 'subfolder/bar'].each do |file|
        source = File.expand_path file, dir
        target = File.expand_path file, current
        assert File.exist?(target), "File #{target} should exist"
        assert FileUtils.identical?(source, target), "File #{file} should be in both locations"
      end
    end
    
    def source
      @source ||= data_path('source.yml')
    end
    
    def source_content
      File.read source
    end
    
    def target
      @target ||= data_path('temp.yml')
    end
    
    def target_content
      File.read target
    end
    
    def dir
      @dir = data_path('sample')
    end
    
    def current
      @current = data_path('temp')
    end
    
    def make_current_working_directory
      FileUtils.mkdir_p current
      FileUtils.cd current
    end
  end
end
