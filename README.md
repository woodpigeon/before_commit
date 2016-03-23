# BeforeCommit

A utility to provide a common set of definitions for code quality utilities
(for example, overcommit, rubocop, scss_lint and brakeman) across multiple
projects.

After installation, running `rake before_commit:run` will copy configuration
files to the current location, and install the code quality utilities.

If the configuration files need to be changed, the gem will be updated and
can be run again - installing the new configuration.

On cloning an application using BeforeCommit, you should run
`rake before_commit:run` before committing any new code to the repository.

## Configuration

This app is configured to install the `overcommit` gem, together with other
gems defined in `source/.overcommit_gems.rb` and to install a common set
of configuration files defined in the `source` folder.

If you want to use an alternative configuration, please feel free to fork
your own copy of this application, and modify the configuration to suit.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'before_commit'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install before_commit

## Usage

BeforeCommit adds a rake task `before_commit:run` to the host environment.

Running the following command

    rake before_commit:run

Will:
- run a set of checks (if specified) and exit unless the checks pass
- copy files from the gem into the current location
- run a set of commands

### Checks

The checks are defined in `config/config.yml`. If the command defined in a
check returns an error, or if the output does not match the regular expression
defined as 'expected', the check will fail. If there was an error, the error
output will be displayed. If the expected match fails, the 'failure_message'
will be displayed.

### Files copied

After any checks have been successfully run, the files in the `source` folder
will be copied to the current location.

### Commands

The next step is for the commands defined in `commands` section of
`config/config.yml` to be run. For example:

    commands:
      - ls
      - "ruby -v"

Would cause the contents of the current directory to be listed, and the ruby
version to be displayed.

## Development

After checking out the repo, run `bin/setup` to install dependencies.
Then, run `rake test` to run the tests. You can also run `bin/console`
for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.
To release a new version, update the version number in `version.rb`, and then
run `bundle exec rake release`, which will create a git tag for the version,
push git commits and tags, and push the `.gem` file
to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/reggieb/before_commit.
