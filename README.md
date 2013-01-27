# Gallery Generator

**Note: I have forked this from [Greer](https://github.com/ggreer/jekyll-gallery-generator), and added support for [Lightbox](http://lokeshdhakar.com/projects/lightbox2/). To use it, follow the instructions [Photo gallery for Jekyll with Lightbox](http://www.garron.me/blog/picture-photo-gallery-jekyll.html)**

This is a [Jekyll plugin](https://github.com/mojombo/jekyll/wiki/Plugins) that generates galleries from directories full of images. It uses [RMagick](http://rmagick.rubyforge.org/) to create thumbnails.

This plugin is quite minimalist. It generates galleries with no pagination, no sub-galleries, and no descriptions. [See my gallery](http://geoff.greer.fm/photos/) for an example of what it looks like.


### Install dependencies

    brew install imagemagick
    sudo gem install rmagick
    sudo gem install exifr

That's what I had to do on OS X. You may need to use different commands.

### To use

    cp gallery_generator.rb jekyll-site/_plugins/
    cp gallery_index.html jekyll-site/_layouts/
    cp gallery_page.html jekyll-site/_layouts/

Copy your image directories into `jekyl-site/photos/`. Here's what my directory structure looks like:

    % ls jekyll-site/photos
    best/                   chile_trip/             japan_trip/
    % ls jekyll-site/photos/chile_trip
    IMG_1039.JPG  IMG_1046.JPG  IMG_1057.JPG  ...

Run `jekyll` and be patient. It can take a while to generate all the thumbnails on the first run. After that, you should have pretty pictures.

### Optional

If you want to have a different path than `/photos/`, set the gallery dir in your `_config.yml`. You can also tweak other settings like the title prefix and thumbnail size. It's also possible to set favorite images that get shown on the index page. Here's what my `_config.yml` looks like:

    gallery:
      title_prefix: "Photos: "
      dir: photos
      galleries:
        chile_trip:
          best_image: IMG_1068.JPG
        japan_trip:
          best_image: IMG_0690.JPG
        best:
          best_image: snaileo_gonzales.jpg
      thumbnail_size:
        x: 800
        y: 800

If you don't set a `best_image` for a gallery, the generator will use the last image. All images and galleries are sorted chronologically by the best_image.
