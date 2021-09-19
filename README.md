# Factory Bot Factory

[![Gem Version](https://badge.fury.io/rb/factory_bot_factory.svg)](https://rubygems.org/gems/factory_bot_factory) ![Gem Version](https://app.travis-ci.com/cdragon1116/factory_bot_factory.svg?branch=main)

A Gem that helps you generate FactoryBot's Factory file from exsiting Hash, OpenStruct or ActiveModels.

The main purpose is to speed up the process of building big factory.

![factory_bot_factory-speed-demo-s](https://user-images.githubusercontent.com/39395058/133915894-c43907b4-8e3f-4a0d-b64e-bda2a5d55748.gif)

## Installation

```ruby
gem 'factory_bot_factory'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install factory_bot_factory


## Quick Demo

- Build a Hash Factory

```ruby
require 'factory_bot_factory'

data = { id: 1, tags: ["tag1", "tag2"], address: { country: "US" }  }
puts FactoryBotFactory.build("order_hash", Hash, data)

# output
FactoryBot.define do
  factory :order_hash, class: Hash do
    id { 1 }
    tags do
      [
        "tag1",
        "tag2"
      ]
    end
    address do
      {
        "country": "US"
      }
    end
    initialize_with { attributes }
  end
end
```

- Nested Hash Factory

```ruby
data = { id: 1, tags: ["tag1", "tag2"], address: { country: "US" }  }
puts FactoryBotFactory.build("order_hash", Hash, data, nested_level: 2)

# output
FactoryBot.define do
  factory :order_hash, class: Hash do
    id { 1 }
    tags do
      [
        "tag1",
        "tag2"
      ]
    end
    address { build(:order_hash_address) }
    initialize_with { attributes }
  end

  factory :order_hash_address, class: Hash do
    country { "US" }
    initialize_with { attributes }
  end
end
```

- Export the file somewhere

```ruby
FactoryBotFactory.build("order_hash", Hash, data, file_path: "spec/factories/order_hash.rb")

require 'factory_bot'
FactoryBot.reload
FactoryBot.build(:order_hash, id: 2)

```

## Supported Factories

- Hash
```ruby
FactoryBotFactory.build("order_hash", Hash, data)
```

- OpenStruct
```ruby
FactoryBotFactory.build("order_open_struct", OpenStruct, data)
```

- Your ActiveModel or ActiveRecord Model
```ruby
FactoryBotFactory.build("user", User, User.first)
```

## Configure your own converter

- Configuration

```ruby
FactoryBotFactory.configure do |config|
  config.string_converter   = Proc.new do |k, v|
    if v.to_s.match?(/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/)
      'Random.uuid()'
    elsif k.to_s.include?('name')
      'Faker::Name.name'
    else
      "'#{v}'"
    end
  end
end
```

- Output
```ruby
FactoryBotFactory.build("order_hash", Hash, { name: 'My Name', id: "de9515ee-006e-4a28-8af3-e88a5c771b93" })

# output
FactoryBot.define do
  factory :order_hash, class: Hash do
    name { Faker::Name.name }
    id { Random.uuid() }
    initialize_with { attributes }
  end
end
```

See more converters [Here](https://github.com/cdragon1116/factory_bot_factory/blob/master/lib/factory_bot_factory/config.rb#L3-L9)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/cdragon1116/factory_bot_factory. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Factorybuilder project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/cdragon1116/factory_bot_factory/blob/master/CODE_OF_CONDUCT.md).
