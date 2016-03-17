#
# Prevent accidentally commiting 'focus: true' in specs.
#
module Overcommit::Hook::PreCommit
  class RspecFocusCheck < Base
    def run
      error_lines = []
      applicable_files.each do |file|
        File.open(file, "r").each_with_index do |line, _index|
          error_lines << line if line =~ / focus:[ ]+true/
        end
      end
      return :fail if error_lines.any?
      :pass
    end
  end
end
