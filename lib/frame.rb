module ScreenSaver
  class Frame
    attr_reader :image
    def initialize(image:, renderer:)
      @image, @renderer = image, renderer

      @reserved_tiles = []
      @their_colors   = []
      @blob = Blob.new(image)

      @x = @renderer.columns + 1
      @y = 0

      @last_moved_at = Gosu.milliseconds
      @move_after = 50
    end

    def update
      free_tiles
      move
      reserve_tiles
    end

    def free_tiles
      @reserved_tiles.each_with_index do |tile, index|
        tile.free
        tile.color = @their_colors[index]
      end
      @reserved_tiles.clear
      @their_colors.clear
    end

    def move
      if Gosu.milliseconds - @last_moved_at >= @move_after
        @last_moved_at = Gosu.milliseconds

        @x -= 1
        if @x <= -(@image.width + 1)
          @x = @renderer.columns + 1

          pos = (@renderer.rows - @image.height)
          @y = pos < 0 ? rand(pos..0) : rand(0..pos)
        end
      end
    end

    def reserve_tiles
      @image.height.times do |y|
        next if @y + y >= @renderer.rows
        next if @y + y < 0

        @image.width.times do |x|
          next if @x + x >= @renderer.columns
          next if @x + x < 0

          _x = @x + x
          _y = @y + y
          tile = @renderer.tile_at?(_x, _y)
          next unless tile

          color = @blob.sample(x, y)
          next if color.alpha <= 10

          @reserved_tiles << tile
          @their_colors << tile.color
          tile.color = color
        end
      end
    end

    class Blob
      def initialize(image)
        @data = image.to_blob.bytes
        @width = image.width
        @height= image.height
      end

      def sample(x, y)
        r, g, b, a = @data[(@width * y + x) * 4, 4]
        Gosu::Color.new(a.ord, r.ord, g.ord, b.ord)
      end
    end
  end
end