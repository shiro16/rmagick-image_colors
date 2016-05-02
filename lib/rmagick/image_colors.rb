require 'RMagick'
require 'rmagick/image_colors/version'

module Magick
  class ImageColors
    def initialize(file_path=nil, image: nil, &block)
      if image
        @image = image
      else
        @image = Magick::Image.read(file_path).first
      end

      aggregate(&block)
    end

    def colors
      @colors
    end

    private
    def aggregate(&block)
      colors = {}
      depth = @image.depth
      @image.color_histogram.each do |pixel|
        if block_given?
          color = block.call(pixel)
        else
          color = pixel[0].to_color(Magick::AllCompliance, false, depth, true)
        end
        colors[color] ||= 0
        colors[color] += pixel[1]
      end
      @colors = colors.sort{|a, b| b[1] <=> a[1]}
    end
  end
end
