require 'awesome_map_marker'
RSpec.describe AwesomeMapMarker do
  it "has a version number" do
    expect(AwesomeMapMarker::VERSION).not_to be nil
  end

  context "fontawesome check" do
    it "fontawesome config read check" do
      icons = AwesomeMapMarker::FontAwesome.icons(:fas)
      expect( icons[0][:id] == "ad").to be true
      expect( icons[icons.length - 1][:id] == "yin-yang") == true

      icons = AwesomeMapMarker::FontAwesome.icons(:fab)
      expect( icons[0][:id] == "500px").to be true
      expect( icons[icons.length - 1][:id] == "zhihu") == true

      icons = AwesomeMapMarker::FontAwesome.icons(:ff)
      expect( icons[0][:id] == "ad") == true
    end
  end

  context "icon generate" do
    it "size check" do
      image = AwesomeMapMarker.generate
      expect(image.width == 128 && image.height == 128) == true

      image = AwesomeMapMarker.generate(size: 512)
      expect(image.width == 512 && image.height == 512) == true

      image = AwesomeMapMarker.generate(size: 1024)
      expect(image.width == 1024 && image.height == 1024) == true

      image = AwesomeMapMarker.generate(size: 1025)
      expect(image.width == 1024 && image.height == 1024) == true

      image = AwesomeMapMarker.generate(size: 0)
      expect(image.nil?) == true

      image = AwesomeMapMarker.generate(size: -1)
      expect(image.nil?) == true
    end

    it "invalid name check" do
      image = AwesomeMapMarker.generate(name: "no-name-font-name")
      expect(image.nil?) == true
    end

    it "file export (see ./tmp directory)" do
      unless File.exist?("./tmp")
        Dir.mkdir 'tmp'
      end
      image = AwesomeMapMarker.generate
      image.write(File.join("./tmp", "fa-map-marker-alt-e45340.png"))
      expect(image.nil?) == false
    end

    it "file export default (see ./tmp directory)" do
      unless File.exist?("./tmp")
        Dir.mkdir 'tmp'
      end
      image = AwesomeMapMarker.generate(
          type: :fas,
          name: 'fa-smile-beam',
          fill_color: '#5e4fab')
      image.write(File.join("./tmp", "fa-smile-beam-5e4fab.png"))
      expect(image.nil?) == false
    end

    it "file export bland (see ./tmp directory)" do
      unless File.exist?("./tmp")
        Dir.mkdir 'tmp'
      end
      image = AwesomeMapMarker.generate(
          type: :fab,
          name: 'fa-github',
          fill_color: '#000000')

      image.write(File.join("./tmp", "fa-github-000000.png"))
      expect(image.nil?) == false
    end

    it "file export solid (see ./tmp directory)" do
      unless File.exist?("./tmp")
        Dir.mkdir 'tmp'
      end
      image = AwesomeMapMarker.generate(
          type: :fas,
          name: 'fa-pastafarianism',
          fill_color: '#b23892',
          size: 64)
      image.write(File.join("./tmp", "fa-pastafarianism-b23892.png"))
      expect(image.nil?) == false
    end

    it "file export size:1024 (see ./tmp directory)" do
      unless File.exist?("./tmp")
        Dir.mkdir 'tmp'
      end
      image = AwesomeMapMarker.generate(
          type: :fas,
          name: 'fa-snowman',
          fill_color: '#c7d2e2',
          size: 1024)
      image.write(File.join("./tmp", "fa-snowman-c7d2e2.png"))
      expect(image.nil?) == false
    end

  end
end
