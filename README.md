# SoftDeletablePetit

Based on [kakurenbo-puti](https://github.com/alfa-jpn/kakurenbo-puti).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'soft_deletable_petit'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install soft_deletable_petit

## Usage

Add `deleted_at` column to your model.

and
```ruby
class YourModel < ActiveRecord::Base
  soft_deletable
end
```

### Methods
```ruby
m.destroy_softly # or destroy_softly!
m.deleted? # => true

m.restore # or m.restore!
m.living? # => true
```

### Scopes
```ruby
YourModel.living
YourModel.deleted
```

## Configuration

In model

```ruby
class YourModel < ActiveRecord::Base
  soft_deletable \
    column:                     :deleted_at,
    soft_delete_method_name:    :destroy_softly,
    restore_method_name:        :restore,
    soft_deleted_scope:         :deleted,
    without_soft_deleted_scope: :living
end
```

and you can change default configuration with `SoftDeletablePetit.configure`.

```ruby
# config/initializers/soft_deletable_petit.rb
SoftDeletablePetit.configure do |config|
  config.column                     = :deleted_at
  config.soft_delete_method_name    = :destroy_softly
  config.restore_method_name        = :restore
  config.soft_deleted_scope         = :deleted
  config.without_soft_deleted_scope = :living
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/soft_deletable_petit.
