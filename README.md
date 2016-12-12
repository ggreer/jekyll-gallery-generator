# Gallery Generator

This is a [Jekyll plugin](http://jekyllrb.com/docs/plugins/) that generates galleries from directories full of images. It uses [RMagick](http://rmagick.rubyforge.org/) to create thumbnails.

This plugin is quite minimalist. It generates galleries with no pagination, no sub-galleries, and no descriptions. [See my gallery](http://geoff.greer.fm/photos/) for an example of what it looks like.

[![Gem Version](https://img.shields.io/gem/v/jekyll-gallery-generator.svg)](https://rubygems.org/gems/jekyll-gallery-generator)

[![Build Status](https://travis-ci.org/ggreer/jekyll-gallery-generator.svg?branch=master)](https://travis-ci.org/ggreer/jekyll-gallery-generator)

[![Floobits Status](https://floobits.com/ggreer/jekyll-gallery-generator.svg)](https://floobits.com/ggreer/jekyll-gallery-generator/redirect)


## Usage

1. Install the `jekyll-gallery-generator` gem, either by running `gem install jekyll-gallery-generator` or by adding `gem 'jekyll-gallery-generator'` to your `Gemfile` and running `bundle`.

2. Add `jekyll-gallery-generator` to the gems list in your `_config.yml`:

    ```
gems:
  - jekyll-gallery-generator
```

3. Copy your image directories into `jekyll-site/photos/`. Here's what my directory structure looks like:

    ```bash
$ ls jekyll-site/photos
best/          chile_trip/  japan_trip/
$ ls jekyll-site/photos/chile_trip
IMG_1039.JPG  IMG_1046.JPG  IMG_1057.JPG
```

4. Run `jekyll build` and be patient. It can take a while to generate all the thumbnails on the first run. After that, you should have pretty pictures.


## Dependencies

* [ImageMagick](http://www.imagemagick.org/)
* [RMagick](https://github.com/rmagick/rmagick)
* [exifr](https://github.com/remvee/exifr/)

### Install dependencies on OS X

```bash
brew install imagemagick
gem install rmagick exifr
```

### Install dependencies on Ubuntu

```bash
apt install libmagick++-dev
gem install rmagick exifr
```

## Configuration

This plugin reads several config options from `_config.yml`. The following options are supported (default settings are shown):

```yaml
gallery:
  dir: photos               # Path to the gallery
  symlink: false            # false: copy images into _site. true: create symbolic links (saves disk space)
  title: "Photos"           # Title for gallery index page
  title_prefix: "Photos: "  # Title prefix for gallery pages. Gallery title = title_prefix + gallery_name
  sort_field: "date_time"   # How to sort galleries on the index page.
                            # Possible values are: title, date_time, best_image
  thumbnail_size:
    x: 400                  # max width of thumbnails (in pixels)
    y: 400                  # max height of thumbnails (in pixels)
  # The following options are for individual galleries.
  galleries:
    chile_trip:
      best_image: IMG_1068.JPG  # The image to show on the gallery index page. Defaults to the last image.
    japan_trip:
      best_image: IMG_0690.JPG
      name: "日本の旅"       # Defaults to directory name, replacing _ with spaces & capitalizing words.
    awesome_stuff:
      best_image: snaileo_gonzales.jpg
      sort_reverse: true    # Reverse sort images in gallery.
    secret_stuff:
      hidden: true          # Don't show this gallery on the index page. People must guess the URL.
    with_info:
      info:
        desc: "Gallery Description" # Info fields can be used in custom templates.
```


## Overriding layouts

If you want to customize the templates used by this generator, copy `gallery_index.html` and `gallery_page.html` to your Jekyll site's `_layouts`:

    cp lib/gallery_index.html jekyll-site/_layouts/
    cp lib/gallery_page.html jekyll-site/_layouts/
