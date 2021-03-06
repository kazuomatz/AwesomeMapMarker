# AwesomeMapMarker

AwesomeMapMarker is a library that generates markers from Fontawesome 5 for plotting on maps such as Google Map, Open Street Map and iOS App etc.


## Requirements
- ImageMagick 6.9x
- MiniMagick

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'awesome_map_marker'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install awesome_map_marker

## Usage


```ruby
require 'awesome_map_marker'

image = AwesomeMapMarker.generate

#image is MiniMagick::Image
image.write('/path/to/save')
```

In the case of no parameter, such a marker is generated.

<img src="https://user-images.githubusercontent.com/2704723/52211823-4f47f280-28ce-11e9-985c-da6eb7a97f30.png"/>

### Parameters

Parameter is Hash.

|  parameter  |  note  |
| ---- | ---- |
|  :type  |  Fontawsome type. : Only ":fas" (solid) and ":fab" (brand) can be specified. ":solid", ":brand" can also be specified. Default is ":fas". |
|  :name  |  Fontawesome font name. such as "fa-smile-beam". Default is "fa-map-marker-alt". |
|  :fill_color  |  Hex color string. such as "#ff0000". Default is - ![#1589F0](https://placehold.it/15/e45340/000000?text=+)  "#e45340". |
|  :size  |  Square side length. Default is 128. If you specify a value greater than 1024, it will be 1024.|


### Return value

This method returns MiniMagick::Image. 

If it can not be generated, return nil.


#### Solid icon

```ruby
image = AwesomeMapMarker.generate(type: :fas,
                                  name: 'fa-smile-beam',
                                  fill_color: '#5e4fab')
```

<img src="https://user-images.githubusercontent.com/2704723/52199531-bc955c80-28a9-11e9-9d60-77f562fd9e8d.png" width="128"/>


#### Brand icon

```ruby
image = AwesomeMapMarker.generate(type: :fab,
                                  name: 'fa-github',
                                  fill_color: '#000000')
```

<img src="https://user-images.githubusercontent.com/2704723/52200171-5a3d5b80-28ab-11e9-9958-6e5142bc8c12.png" width="128"/>

#### Size

```ruby
image = AwesomeMapMarker.generate( type: :fas,
                                   name: 'fa-pastafarianism',
                                   fill_color: '#b23892',
                                   size: 64)
```
<img src="https://user-images.githubusercontent.com/2704723/52200581-81485d00-28ac-11e9-97f8-7aad9e251152.png" width="64"/>

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kazuomatz/awesome_map_marker. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

- The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
- All font files licensed under [SIL OFL 1.1](http://scripts.sil.org/OFL)

## Code of Conduct

Everyone interacting in the AwesomeMapMarker project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/awesome_map_marker/blob/master/CODE_OF_CONDUCT.md).
