require 'exifr'
require 'RMagick'
include Magick

include FileUtils

$image_extensions = [".png", ".jpg", ".jpeg", ".gif"]

module Jekyll
  class GalleryFile < StaticFile
    def write(dest)
      return false
    end
  end

  class GalleryIndex < Page
    def initialize(site, base, dir, galleries)
      @site = site
      @base = base
      @dir = dir.gsub("source/", "")
      @name = "index.html"

      self.process(@name)
      self.read_yaml(File.join(base, "_layouts"), "gallery_index.html")
      self.data["title"] = site.config["gallery"]["title"] || "Photos"
      self.data["galleries"] = []
      begin
        sort_field = site.config["gallery"]["sort_field"] || "date_time"
        galleries.sort! {|a,b| b.data[sort_field] <=> a.data[sort_field]}
      rescue Exception => e
        puts "Error sorting galleries: #{e}"
        puts e.backtrace
      end
      if site.config["gallery"]["sort_reverse"]
        galleries.reverse!
      end
      galleries.each {|gallery|
        unless gallery.hidden
          self.data["galleries"].push(gallery.data)
        end
      }
    end
  end

  class GalleryPage < Page
    attr_reader :hidden

    def initialize(site, base, dir, gallery_name)
      @site = site
      @base = base
      @dest_dir = dir.gsub("source/", "")
      @dir = @dest_dir
      @name = "index.html"
      @images = []
      @hidden = false

      config = site.config["gallery"] || {}
      gallery_config = {}
      best_image = nil
      max_size_x = 400
      max_size_y = 400
      scale_method = config["scale_method"] || "fit"
      begin
        max_size_x = config["thumbnail_size"]["x"]
      rescue
      end
      begin
        max_size_y = config["thumbnail_size"]["y"]
      rescue
      end
      begin
        gallery_config = config["galleries"][gallery_name] || {}
      rescue
      end
      self.process(@name)
      self.read_yaml(File.join(base, "_layouts"), "gallery_page.html")
      self.data["gallery"] = gallery_name
      gallery_title_prefix = config["title_prefix"] || "Photos: "
      gallery_name = gallery_name.gsub("_", " ").gsub(/\w+/) {|word| word.capitalize}
      begin
        gallery_name = gallery_config["name"] || gallery_name
      rescue
      end
      self.data["name"] = gallery_name
      self.data["title"] = "#{gallery_title_prefix}#{gallery_name}"
      thumbs_dir = "#{site.dest}/#{@dest_dir}/thumbs"
      begin
        @hidden = gallery_config["hidden"] || false
      rescue
      end
      if @hidden
        self.data["sitemap"] = false
      end

      FileUtils.mkdir_p(thumbs_dir, :mode => 0755)
      Dir.foreach(dir) do |image|
        if image.chars.first != "." and image.downcase().end_with?(*$image_extensions)
          @images.push(image)
          best_image = image
          @site.static_files << GalleryFile.new(site, base, "#{@dest_dir}/thumbs/", image)
          if File.file?("#{thumbs_dir}/#{image}") == false or File.mtime("#{dir}/#{image}") > File.mtime("#{thumbs_dir}/#{image}")
            begin
              m_image = ImageList.new("#{dir}/#{image}")
              m_image.send("resize_to_#{scale_method}!", max_size_x, max_size_y)
              puts "Writing thumbnail to #{thumbs_dir}/#{image}"
              m_image.write("#{thumbs_dir}/#{image}")
            rescue e
              puts "Error generating thumbnail for #{dir}/#{image}: #{e}"
              puts e.backtrace
            end
            GC.start
          end
        end
      end
      begin
        @images.sort!
        if gallery_config["sort_reverse"]
          @images.reverse!
        end
      rescue Exception => e
        puts "Error sorting images in gallery #{gallery_name}: #{e}"
        puts e.backtrace
      end

      self.data["images"] = @images
      self.data["best_image"] = gallery_config["best_image"] || best_image
      begin
        self.data["date_time"] = EXIFR::JPEG.new("#{dir}/#{best_image}").date_time.to_i
      rescue Exception => e
        self.data["date_time"] = 0
        puts "Error getting date_time for #{dir}/#{best_image}: #{e}"
      end
    end
  end

  class GalleryGenerator < Generator
    safe true

    def generate(site)
      unless site.layouts.key? "gallery_index"
        return
      end
      dir = site.config["gallery"]["dir"] || "photos"
      galleries = []
      begin
        Dir.foreach(dir) do |gallery_dir|
          gallery_path = File.join(dir, gallery_dir)
          if File.directory?(gallery_path) and gallery_dir.chars.first != "."
            gallery = GalleryPage.new(site, site.source, gallery_path, gallery_dir)
            gallery.render(site.layouts, site.site_payload)
            gallery.write(site.dest)
            site.pages << gallery
            galleries << gallery
          end
        end
      rescue Exception => e
        puts "Error generating galleries: #{e}"
        puts e.backtrace
      end

      gallery_index = GalleryIndex.new(site, site.source, dir, galleries)
      gallery_index.render(site.layouts, site.site_payload)
      gallery_index.write(site.dest)
      site.pages << gallery_index
    end
  end
end
