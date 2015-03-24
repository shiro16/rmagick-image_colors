# Magick::ImageColors

Color analysis of image. rmagick enhancement class.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rmagick-image_colors'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rmagick-image_colors

## Usage

```ruby
image_colors = Magick::ImageColors.new('http://example.com/image_colors.png')
image_colors.colors

image_colors = Magick::ImageColors.new('spec/fixtures/test.jpg')
image_colors.colors
```

## Contributing

1. Fork it ( https://github.com/shiro16/rmagick-image_colors/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
