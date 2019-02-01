module AwesomeMapMarker

  class PngConverter

    IMPORT_FONT_FILENAME = File.join(Rails.root,'public','fonts','fontawesome-webfont.ttf')
    IMPORT_YAML_FILENAME = File.join(Rails.root,'app','lib','icons.yml')




    def initialize(size: 128, fill_color:'#000000',threshold: 0.01)
      @width = size
      @height = size
      @font_size = (size * 0.76).ceil
      @font_path = IMPORT_FONT_FILENAME
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
        draw = Magick::Draw.new
        image = Magick::Image.new(@width, @height)
        image = image.matte_replace(0, 0)
        draw_char(draw, image, char)
        return image
      else
        return nil
      end

    end

    def icon_data(name)
      icons_data_yml.each do |icon|
        if icon['id'] == name
          return icon
        end
      end
      return nil
    end

    def icons_data
      result = []
      icons_data_yml.each do |icon|
        result << { id: icon['id'], unicode: icon['unicode'] }
        next unless icon['aliases']
        icon['aliases'].each do |alias_name|
          result << { id: alias_name, unicode: icon['unicode'] }
        end
      end
      result
    end

    def icons_data_yml
      yml_path = IMPORT_YAML_FILENAME
      YAML.load_file(yml_path)['icons']
    end

  end

end