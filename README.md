# Factory Bot Factory

A Gem that helps you generate FactoryBot's Factory file from exsiting Hash, OpenStruct or ActiveModels.

The main purpose is to speed up the process of building big factory.

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
```
FactoryBotFactory.build("order_open_struct", OpenStruct, data)
```

- Your ActiveModel or ActiveRecord Model
```
FactoryBotFactory.build("user", User, user_instance)
```

## Configure your own converter

- Configure

```ruby
FactoryBotFactory.configure do |config|
  config.string_converter   = Proc.new do |k, v|
    if k.to_s.include?('name')
      'Faker::Name.name'
    else
      "'#{v}'"
    end
  end
end

FactoryBotFactory.build("order_hash", Hash, { name: 'My Name' })

# output
FactoryBot.define do
  factory :order_hash, class: Hash do
    name { Faker::Name.name }
    initialize_with { attributes }
  end
end
```

See move converters 'lib/factory_bot_factory/config.rb'


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/cdragon1116/factory_bot_factory. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Factorybuilder project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/cdragon1116/factory_bot_factory/blob/master/CODE_OF_CONDUCT.md).
