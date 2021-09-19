# Factory Bot Factory

[![Gem Version](https://badge.fury.io/rb/factory_bot_factory.svg)](https://rubygems.org/gems/factory_bot_factory) ![Gem Version](https://app.travis-ci.com/cdragon1116/factory_bot_factory.svg?branch=main)

A Gem that helps you generate FactoryBot's Factory file from exsiting Hash, OpenStruct or ActiveModels.

![factory_bot_factory_speed_demo](https://user-images.githubusercontent.com/39395058/133921801-e6c2b61d-71f1-4b99-b096-a0304fdbce87.gif)

## Installation

```ruby
gem 'factory_bot_factory'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install factory_bot_factory
```


## Quick Demo

```ruby
require 'factory_bot_factory'

puts FactoryBotFactory.build({ id: 1 })
puts FactoryBotFactory.build(OpenStruct.new(id: 1))
puts FactoryBotFactory.build(User.last)
puts FactoryBotFactory.build(User.new)
```


## More Options

- `nested_level` - Build Nested Hash Factory (only support Hash and OpenStruct)

```ruby
data = { id: 1, tags: ["tag1", "tag2"], address: { country: "US" }  }
puts FactoryBotFactory.build(data, nested_level: 2)

# output
FactoryBot.define do
  factory :hash, class: Hash do
    id { 1 }
    tags do
      [
        "tag1",
        "tag2"
      ]
    end
    address { build(:hash_address) }
    initialize_with { attributes }
  end

  factory :hash_address, class: Hash do
    country { "US" }
    initialize_with { attributes }
  end
end
```

- `file_path` - Export output as file somewhere

```ruby
FactoryBotFactory.build(data, file_path: "spec/factories/hash.rb")

require 'factory_bot'
FactoryBot.reload
FactoryBot.build(:hash, id: 2)
```

- `factory_name` - Specifize Factory Name

```ruby
puts FactoryBotFactory.build({ id: 1 }, factory_name: 'order')

# output
FactoryBot.define do
  factory :order, class: Hash do
    id { 1 }
    initialize_with { attributes }
  end
end
```

- `klass` - Specifize Output Data Structure: Hash, OpenStruct and your ActiveModel or ActiveRecord Model

You can convert your Hash object to OpenStruct factory.

```ruby
puts FactoryBotFactory.build({ id: 1 }, factory_name: 'order', klass: OpenStruct)

# output
FactoryBot.define do
  factory :order, class: OpenStruct do
    id { 1 }
    to_create {}
  end
end
```

## Configuration

- Default factory path

By configuring `factory_path`, it allows file auto-generation without specifying `file_path`.

```ruby
FactoryBotFactory.configure do |config|
  config.factory_path = 'spec/factories'
end
```

- Customize your own converter:

Converter should respond to `call` method and return single or array of executable values.

```ruby
FactoryBotFactory.configure do |config|
  config.string_converter = Proc.new { |k, v|
    if v.to_s.match?(/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/)
      'Random.uuid()'
    elsif k.to_s.include?('name')
      'Faker::Name.name'
    else
      "'#{v}'"
    end
  }

  config.numeric_converter = Proc.new { |k, v| 'rand(99)' }
end

FactoryBotFactory.build({ name: 'My Name', id: "de9515ee-006e-4a28-8af3-e88a5c771b93", age: 10 })

# output
FactoryBot.define do
  factory :hash, class: Hash do
    name { Faker::Name.name }
    id { Random.uuid() }
    age { rand(99) }
    initialize_with { attributes }
  end
end
```

See more converters [Here](https://github.com/cdragon1116/factory_bot_factory/blob/release/1.1.0/lib/factory_bot_factory/config.rb#L3-L13)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/cdragon1116/factory_bot_factory. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Factorybuilder project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/cdragon1116/factory_bot_factory/blob/master/CODE_OF_CONDUCT.md).
