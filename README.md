# Vinery

A Ruby interface for [Vine](http://vine.co).

## Installation

Add this line to your application's Gemfile:

    gem 'vinery'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install vinery

## Usage

Vine's API requires _all_ requests to be authenticated (via a session cookie) with a valid Vine username and password. Vinery will authenticate you upon initialization.

To begin, `require` Vinery in your ruby script and then create a new instance of `Vinery::API` by passing your Vine username and password as parameters.

```ruby
require 'vinery'
vinery = Vinery::API.new(vine_username,vine_password)
```

If Vine rejects your credentials, Vinery will raise `InvalidCredentialsError`. If no errors occur, then you have successfully authenticated with Vine and you're ready to go!

To learn more about how to work with `Vinery::API`, [browse the source code](lib/vinery/api.rb).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
