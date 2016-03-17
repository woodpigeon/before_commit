require 'test_helper'

module BeforeCommit
  class RunnerTest < Minitest::Test
    def test_run_triggers_processes
      FileManager.stub(:copy_dir_to_current, true) do
        assert Runner.run
      end
    end
    
    def test_source_dir
      path = File.expand_path '../../source', File.dirname(__FILE__)
      assert_equal path, Runner.source_dir
    end
  end
end
