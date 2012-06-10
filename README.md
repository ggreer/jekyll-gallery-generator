# Gallery Generator

This is a [Jekyll plugin](https://github.com/mojombo/jekyll/wiki/Plugins) that will take a directory full of images and generate galleries. It uses [RMagick](http://rmagick.rubyforge.org/) to create thumbnails.

See [my gallery](http://geoff.greer.fm/photos/) for an example of what it looks like.

### Install dependencies

    brew install imagemagick
    gem install RMagick

### To use:

    cp gallery\_generator.rb jekyll-site/\_plugins/
    cp gallery\_index.html jekyll-site/\_layouts/
    cp gallery\_page.html jekyll-site/\_layouts/