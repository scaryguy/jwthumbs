# JWthumbs

JWthumbs is a Ruby gem to create a .VTT file and a sprite of thumbnails of a given video file (mp4, mpg, avi, mov and so on...). Heavily inspired by [vlanard](https://github.com/vlanard)'s great [Python script](https://github.com/vlanard/videoscripts).

## System requirements

In order to use JWthumbs, you must have [ffmpeg](http://www.ffmpeg.org/download.html) and [imagemagick](http://www.imagemagick.org/script/binary-releases.php) installed. 


## Installation

Installation of JWthumbs is pretty straigt forward. Add this to your Gemfile:

    gem 'jwthumbs'

And then:

    $ bundle install

Or install it yourself as:

    $ gem install jwthumbs

## Usage

Instantiate your video file:

```ruby
movie = Jwthumbs::Movie.new("YOUR_VIDEO.mp4")
```

`Jwthumbs::Movie.new` accepts second parameter as a `options` hash. You can configure several stuff at the same time you instantiate your video like this:

```ruby
movie = Jwthumbs::Movie.new("YOUR_VIDEO.mp4", seconds_between: 60, sprite_name: "my_sprite_name.jpg")
```

or after you instentiated your video, you can use `Jwthumbs::Movie` file to configure things:

```ruby
movie = Jwthumbs::Movie.new("YOUR_VIDEO.mp4")
movie.seconds_between = 60
movie.sprite_name = "my_sprite_name.jpg"
```


and then to create your thumbnails and .VTT file just run this command.

```ruby
movie.create_thumbs!
```


If you haven't changed defaults, your `_sprite.jpg` and `_thumbs.vtt` file will be exportes to `output` directory of your root path.


## Configuration

`:outdir` (string): The path you want your files to be exported. Example: /this/is/my/path 

`:seconds_between` (integer): Time in seconds between each of snapshots to be taken. Default is video duration / 10. 

`:thumb_width` (integer): Width of thumbnails that will be placed in the sprite of images. Bigger thumb width size means bigger sprite and bigger file size. Default is 100 which is also recommended.

`:vttfile` (string): Name of your .VTT file. Default is `file_name_thumbs.vtt`

`:spritefile` (string): Name of your sprite file. Default is `file_name_sprite.jpg`

`:clear_files` (true / false): Thumbnails should be deleted or not? Before creating sprite, number of snapshots will be taken from the video in respect of `:seconds_between` parameter. Sprite is created by `montage`ing those thumbnails into one file. So you may need to use thumbnails or you may not. Your choice. Default is `true`.


## Contributing

Any kind of participation is welcomed.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## Author, Licence and Permissions

scaryguy - 2014 - MIT

	CAUTION: YOU CAN NOT USE THIS GEM IN APPLICATIONS HAVING ANY KIND OF INAPPROPRIATE CONTENT (see YouTube's [policy](http://www.youtube.com/yt/policyandsafety/policy.html) that I support).

