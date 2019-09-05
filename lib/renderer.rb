module ScreenSaver
  class Renderer
    def initialize(cell_size:, percent_changed_per_frame: 0.0055)
      @cell_size = cell_size
      @percent_changed_per_frame = percent_changed_per_frame

      @columns = (Gosu.screen_width / @cell_size.to_f).ceil
      @rows    = (Gosu.screen_height / @cell_size.to_f).ceil

      @tiles = []
      generate_grid

      @colorizers = []
      @colorizers << @red   = Colorizer.new(min: 100, max: 200)
      @colorizers << @green = Colorizer.new(min: 100, max: 180)
      @colorizers << @blue  = Colorizer.new(min: 100, max: 180)
    end

    def generate_grid
      @rows.times do |y|
        @columns.times do |x|
          @tiles << Tile.new(x: x, y: y, cell_size: @cell_size)
        end
      end
    end

    def draw
      @tiles.each(&:draw)
    end

    def update
      color = next_color
      @tiles.sample(@tiles.size * @percent_changed_per_frame).each do |tile|
        tile.color = color
      end

      @colorizers.each(&:update)
    end

    def next_color
      Gosu::Color.rgba(@red.value, @green.value, @blue.value, 240)
    end

    def tile_at?(x, y)
      @tiles.dig(@columns * y + x)
    end
  end
end