# frozen_string_literal: false

require 'awesome_map_marker/version'
require 'mini_magick'
require 'yaml'
require 'tempfile'

# ##########################################
#  AwesomeMapMarker
#  Version 0.1.0
#  2019-02-04
#  Author Kazuomatz
# ##########################################
module AwesomeMapMarker
  class Error < StandardError; end

  def self.generate(type: :fas,
                    name: 'fa-map-marker-alt',
                    size: 128,
                    fill_color: '#e45340')

    size = 1024 if size > 1024
    return nil if size <= 0

    font_image = FontAwesome.generate(type: type, name: name, size: size * 0.6)
    return nil if font_image.nil?

    tmp_file = Tempfile.new(%w[icon .png])
    tmp_file.close

    MiniMagick::Tool::Convert.new do |magick|
      magick << File.expand_path('../app/assets/images/icon-base.png', __dir__)
      magick.resize("#{size}x#{size}")
      magick.fuzz '100%'
      magick.fill fill_color
      magick.opaque '#0000FF'
      magick << tmp_file.path
    end

    base_image = MiniMagick::Image.open(tmp_file.path)

    tmp_file.unlink
    base_image.composite(font_image) do |composite|
      composite.compose 'over'
      composite.gravity 'center'
      composite.geometry "+0-#{size * 0.04}"
    end
  end

  #
  #  Convert web-font to PNG
  #
  class FontAwesome
    class << self
      def generate(type: :fas,
                   name: 'map-marker',
                   size: 128,
                   fill_color: '#FFFFFF')

        # MiniMagick.logger.level = Logger::DEBUG

        name.delete_prefix!('fa-')
        icon_data = icon_data(type.to_s, name.to_s)
        return nil if icon_data.nil?

        x =  0
        y =  (size / 12.8) * -1

        font_size = (size * 0.76).ceil

        unicode = icon_data[:unicode]
        char = [Integer("0x#{unicode}")].pack('U*')
        path = font_path(icon_type(type))

        image = MiniMagick::Image.open(
          File.expand_path('../app/assets/images/base.png', __dir__)
        )
        image.combine_options do |config|
          config.resize "#{size}x#{size}"
          config.font path
          config.gravity 'center'
          config.pointsize font_size
          config.kerning 0
          config.stroke 'transparent'
          config.fill fill_color
          config.draw "text #{x},#{y} '#{char}'"
        end
        image
      end

      def icons(type)
        icons_data_yml(icon_type(type).to_s)
      end

      private

      def icon_data(type, name)
        icons_data_yml(icon_type(type).to_s).select do |icon|
          icon[:id] == name
        end.first
      end

      def icon_type(type)
        return :fas if type.nil?

        case type.to_s
        when 'far', 'regular'
          :far
        when 'fab', 'brand'
          :fab
        else
          :fas
        end
      end

      def icons_data_yml(type)
        yml_path = File.expand_path(
          "../../config/#{icon_type(type)}.yml",
          __FILE__
        )
        YAML.load_file(yml_path)
      end

      def font_path(type)
        path = File.expand_path('../app/assets/fonts', __dir__)
        case icon_type(type).to_s
        when 'far'
          File.join(path, 'fa-regular-400.ttf')
        when 'fab'
          File.join(path, 'fa-brands-400.ttf')
        else # fas
          File.join(path, 'fa-solid-900.ttf')
        end
      end
    end
  end
end
