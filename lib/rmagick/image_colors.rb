require 'RMagick'
require 'rmagick/image_colors/version'

module Magick
  class ImageColors
    def initialize(file_path)
      @image = Magick::Image.read(file_path).first
      aggregate
    end

    def colors
      @colors
    end

    private
    def aggregate
      colors = {}
      @image.color_histogram.each do |pixel|
        color = pixel[0].to_color(Magick::AllCompliance, false, @image.depth, true)
        colors[color] ||= 0
        colors[color] += pixel[1]
      end
      @colors = colors.sort{|a, b| b[1] <=> a[1]}
    end
  end
end
