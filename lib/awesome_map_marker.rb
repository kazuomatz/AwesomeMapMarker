require 'awesome_map_marker/version'
require 'mini_magick'
require 'yaml'
require 'tempfile'

module AwesomeMapMarker
  class Error < StandardError; end
  # Your code goes here...
  #


  def self.generate(type: :fas, name: "fa-map-marker-alt", size: 128, fill_color: "#000000")

    tmp_file = Tempfile.new(%w(icon .png))
    tmp_file.close
    p tmp_file.path

    MiniMagick::Tool::Convert.new do |magick|
      magick << File.expand_path("../../app/assets/images/icon-base.png", __FILE__)
      magick.resize("#{size}x#{size}")
      magick.fuzz '100%'
      magick.fill fill_color
      magick.opaque '#0000FF'
      magick << tmp_file.path
    end

    base_image = MiniMagick::Image.open(tmp_file.path)
    font_image = FontToPng.generate(type: type, name: name, size: size * 0.6)

    tmp_file.unlink
    base_image.composite(font_image) do |composite|
      composite.compose "over"
      composite.gravity "center"
      composite.geometry "+0-#{size * 0.04}"
    end
  end


  class FontToPng

    def self.generate(type: :fas, name: 'map-marker',size:128, fill_color: '#FFFFFF')
      MiniMagick.logger.level = Logger::DEBUG

      name.delete_prefix!("fa-")
      icon_data = icon_data(type.to_s, name.to_s)
      x =  0
      y =  (size / 12.8) * -1


      font_size = (size * 0.76).ceil

      if icon_data
        unicode = icon_data[:unicode]
        char = [Integer("0x#{unicode}")].pack('U*')
        path = font_path(icon_type(type))

        image = MiniMagick::Image.open(File.expand_path("../../app/assets/images/base.png", __FILE__))
        image.combine_options do |config|
          config.resize "#{size}x#{size}"
          config.font path
          config.gravity 'center'
          config.pointsize font_size
          config.kerning  0
          config.stroke "transparent"
          config.fill fill_color
          config.draw "text #{x},#{y} '#{char}'"
        end
        return image
      else
        return nil
      end
    end

    private

    def self.icon_type(type)
      return :fas if type.nil?
      case type.to_s
      when "far", "regular"
        :far
      when "fab", "brand"
        :fab
      else
        :fas
      end
    end

    def self.icon_data(type, name)
      icons_data_yml(icon_type(type).to_s).select { |icon| icon[:id] === name }.first
    end

    def self.icons_data_yml(type)
      yml_path = File.expand_path("../../config/#{icon_type(type)}.yml", __FILE__)
      YAML.load_file(yml_path)
    end

    def self.font_path(type)
      path = File.expand_path("../../app/assets/fonts", __FILE__)
      case icon_type(type).to_s
      when "far"
        File.join(path,"fa-regular-400.ttf")
      when "fab"
        File.join(path,"fa-brands-400.ttf")
      else  #fas
        File.join(path,"fa-solid-900.ttf")
      end
    end

  end


end
