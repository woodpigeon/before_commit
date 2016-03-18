require 'test_helper'

module BeforeCommit
  class CommandTest < Minitest::Test
    def test_run    
      output = command.run echo
      assert_equal input, output.strip
      assert_equal echo,  command.input
      assert_equal input, command.success.strip
      assert_equal nil,   command.error
      assert_equal input, command.result.strip
    end
    
    def test_run_with_error
      cmd = 'cat non-existent.file'
      output = command.run cmd
      assert_match(/No such file/, output)
      assert_equal cmd,            command.input
      assert_equal nil,            command.success
      assert_match(/No such file/, command.error)
      assert_match(/No such file/, command.result)
    end
    
    def test_run_with_non_existent_command
      cmd = 'xxxxxxxxx'
      output = command.run cmd
      assert_match(/No such file/, output)
      assert_equal cmd,            command.input
      assert_equal nil,            command.success
      assert_match(/No such file/, command.error)
      assert_match(/No such file/, command.result)
    end
    
    def test_success
      test_run
      assert_equal true, command.success?
    end
    
    def test_success_with_error
      test_run_with_error
      assert_equal false, command.success?
    end
    
    def test_run_clears_previous_result
      test_run
      test_run_with_error
      test_run
    end
    
    def input
      @input ||= 'foo'
    end
    
    def echo
      "echo #{input}"
    end
    
    def command
      @command ||= Command.new
    end
  end
end
