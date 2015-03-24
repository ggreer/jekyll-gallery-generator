# Gallery Generator

This is a [Jekyll plugin](http://jekyllrb.com/docs/plugins/) that generates galleries from directories full of images. It uses [RMagick](http://rmagick.rubyforge.org/) to create thumbnails.

This plugin is quite minimalist. It generates galleries with no pagination, no sub-galleries, and no descriptions. [See my gallery](http://geoff.greer.fm/photos/) for an example of what it looks like.

[![Build Status](https://travis-ci.org/ggreer/jekyll-gallery-generator.svg?branch=master)](https://travis-ci.org/ggreer/jekyll-gallery-generator)


## Usage

1. Install the `jekyll-gallery-generator` gem, either by running `gem install jekyll-gallery-generator` or by adding `gem 'jekyll-gallery-generator'` to your `Gemfile` and running `bundle`.

2. Add `jekyll-gallery-generator` to the gems list in your `_config.yml`:


    gems:
      - jekyll-gallery-generator


3. Copy your image directories into `jekyl-site/photos/`. Here's what my directory structure looks like:

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


## Configuration

This plugin reads several config options from `_config.yml`. The following options are supported (default settings are shown):

```yaml
gallery:
  # path to the gallery
  dir: photos
  # title for gallery index
  title: "Photos"
  # title prefix for gallery page. title=title_prefix+gallery_name
  title_prefix: "Photos: "
  # field to control sorting of galleries for the index page
  # (possible values are: title, date_time, best_image)
  sort_field: "date_time"
  # sizes for thumbnails
  thumbnail_size:
    x: 400
    y: 400
  # custom configuration for individual gallery
  # best_image is image for the index page (defaults to last image)
  galleries:
    chile_trip:
      best_image: IMG_1068.JPG
    japan_trip:
      best_image: IMG_0690.JPG
    best:
      best_image: snaileo_gonzales.jpg
```


## Overriding layouts

If you want to customize the templates used by this generator, copy `gallery_index.html` and `gallery_page.html` to your Jekyll site's `_layouts`:

    cp lib/gallery_index.html jekyll-site/_layouts/
    cp lib/gallery_page.html jekyll-site/_layouts/
