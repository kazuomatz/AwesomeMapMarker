require 'awesome_map_marker/version'
require 'mini_magick'
require 'yaml'

module AwesomeMapMarker
  class Error < StandardError; end
  # Your code goes here...
  #
  def self.greet
    p 'Hello'
  end

  def self.generate(size: 128,fill_color:'#000000')
    MiniMagick::Tool::Convert.new do |magick|
      magick << File.expand_path("./app/assets/images/icon-base.png")
      magick.resize("#{size}x#{size}")
      magick.fuzz '100%'
      magick.fill fill_color
      magick.opaque '#0000FF'
      magick << "/Users/kazuo-mt/Desktop/icon.png"
    end
  end


  class PingConverter

    def initialize(size: 128, fill_color:'#000000',threshold: 0.01)
      @width = size
      @height = size
      @font_size = (size * 0.76).ceil
      @char_position = { x: 0, y: (size / 12.8) * -1 }
      @threshold = threshold
      @fill_color = fill_color
      MiniMagick.logger.level = Logger::DEBUG
    end

    def generate(type, name)
      icon_data = icon_data(type, name)
      if icon_data
        unicode = icon_data[:unicode]
        char = [Integer("0x#{unicode}")].pack('U*')
        image = MiniMagick::Image.open(File.expand_path("./app/assets/images/base.png"))
        image.combine_options do |config|
          config.resize "#{@width}x#{@height}"
          config.font PingConverter.font_path(type)
          config.gravity 'center'
          config.pointsize @font_size
          config.kerning  0
          config.fill '#ffffff'
          config.draw "text #{@char_position[:x]},#{@char_position[:y]} #{char}"
        end
        return image
      else
        return nil
      end
    end

    def icon_data(type, name)
      icons_data_yml(type).map { |icon| icon[:id] === name ?  icon : nil }.compact.first
    end

    def icons_data_yml(type)
      yml_path = File.expand_path("./config/#{type}.yml")
      YAML.load_file(yml_path)
    end

    def self.icon_type(type)
      return "fas" if type.nil?
      case type.to_s
      when "far", "regular"
        "far"
      when "fab", "brand"
        "fab"
      else
        "fas"
      end
    end

    def self.font_path(type)
      path = File.expand_path("./app/assets/fonts")
      case icon_type(type)
      when "far"
        File.join(path,"fa-regular-400.ttf")
      when "fab"
        File.join(path,"fa-brands-400.ttf")
      else  #fas
        File.join(path,"fa-solid-900.ttf")
      end
    end




    def self.blob(type)





    end



  end

end
