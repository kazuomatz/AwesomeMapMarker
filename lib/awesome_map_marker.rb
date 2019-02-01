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

  class PingConverter

    def initialize(size: 128, type: "far", fill_color:'#000000',threshold: 0.01)
      @width = size
      @height = size
      @font_size = (size * 0.76).ceil
      @font_path = self.font_path()
      @char_position = { x: @width * 0.53, y: (@font_size + @height) * 0.45 }
      @threshold = threshold
      @fill_color = fill_color
    end


    def draw_char(draw, image, char, char_position = @char_position)
      draw.font = @font_path
      draw.fill = '#ffffff'
      draw.gravity = Magick::CenterGravity
      draw.stroke = 'transparent'
      draw.pointsize = @font_size
      draw.text_antialias = true
      draw.kerning = 0
      draw.text_align(Magick::CenterAlign)
      draw.text(char_position[:x], char_position[:y], char)
      draw.draw(image)
    end


    def generate(name)
      icon_data = icon_data(name)
      if icon_data
        unicode = icon_data['unicode']
        char = [Integer("0x#{unicode}")].pack('U*')
        image = Magick::Image.new(@width, @height)
        image = image.matte_replace(0, 0)
        draw_char(draw, image, char)
        return image
      else
        return nil
      end

    end

    def icon_data(name)
      icons_data_yml.map { |icon| icon[:id] === name ?  icon : nil }.compact.first
    end

    def icons_data_yml(type)
      yml_path = File.expand_path("../config/#{type}.yml",__FILE__)
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
      path = File.expand_path("../app/assets/font",__FILE__)
      case icon_type(type)
      when "far"
        file.join(path,"fa-regular-400.ttf")
      when "fab"
        file.join(path,"fa-brands-400.ttf")
      else  #fas
        file.join(path,"fa-solid-900.ttf")
      end
    end




    def self.blob(type)





    end



  end

end
