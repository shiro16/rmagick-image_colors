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
      depth = @image.depth
      @colors = @image.color_histogram.inject({}) do |colors, pixel|
                  color = if block_given?
                            block.call(pixel, depth)
                          else
                            pixel[0].to_color(Magick::AllCompliance, false, depth, true)
                          end

                  next if color.nil?

                  colors[color] ||= 0
                  colors[color] += pixel[1]
                  colors
                end.sort{|a, b| b[1] <=> a[1]}
    end
  end
end
