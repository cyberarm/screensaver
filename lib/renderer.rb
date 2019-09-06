module ScreenSaver
  class Renderer
    attr_reader :cell_size, :columns, :rows
    def initialize(cell_size:, percent_changed_per_frame: 0.0055)
      @cell_size = cell_size
      @percent_changed_per_frame = percent_changed_per_frame

      @columns = (Gosu.screen_width / @cell_size.to_f).ceil
      @rows    = (Gosu.screen_height / @cell_size.to_f).ceil

      @tiles = []
      generate_grid
      @all_set_once = false

      @colorizers = []
      @colorizers << @red   = Colorizer.new(min: 100, max: 200)
      @colorizers << @green = Colorizer.new(min: 100, max: 180)
      @colorizers << @blue  = Colorizer.new(min: 100, max: 180)

      @frames = []
    end

    def add_frame(frame)
      @frames << frame
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
      if @all_set_once
        update_tiles(@tiles)
      else
        tiles = @tiles.select{ |tile| tile.color == Gosu::Color::NONE}
        update_tiles(tiles, true)

        @all_set_once = true if tiles.size == 0
      end

      @colorizers.each(&:update)
      @frames.each(&:update)
    end

    def next_color
      Gosu::Color.rgba(@red.value, @green.value, @blue.value, 240)
    end

    def update_tiles(array, new_color_for_each_tile = false)
      color = next_color

      array.sample((@tiles.size * @percent_changed_per_frame).ceil).each do |tile|
        color = next_color if new_color_for_each_tile
        next if tile.reserved?
        tile.color = color
      end
    end

    def tile_at?(x, y)
      @tiles.dig(@columns * y + x)
    end
  end
end