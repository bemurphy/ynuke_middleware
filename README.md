# YnukeMiddleware

SUPER BETA

Naive rack middleware to attemp to block requests that appear to contain yaml attacks.
This needs to be as close to the head of your inbound rack stack as possible.

This is not a replacement for patching, but rather an attempt to mitigate new
bugs or mistakes to buy you the hour while you update.

Also, note the middleware forbids the very broad string `!ruby/`.  If you run
a service that hosts ruby code or discussions, it would likely hit many false
positives.

## Installation

Add this line to your application's Gemfile:

    gem 'ynuke_middleware'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ynuke_middleware

## Usage

```ruby
use YnukeMiddleware, message: "Forbidden by filter"
```

The message param is optional but defaulted to the above.

Also, again this needs to be as close to the head of your inbound
rack stack as possible.

## Todo

This is extremely naive and can possibly be bypassed by encodings.  Check
into that.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
