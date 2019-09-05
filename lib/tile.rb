module ScreenSaver
  class Tile
    attr_accessor :reserved, :color
    def initialize(x:, y:, cell_size:, reserved: false, color: Gosu::Color::NONE)
      @x, @y, @cell_size = x, y, cell_size
      @reserved = reserved
      @color = color
    end

    def reserved? @reserved end

    def draw
      Gosu.draw_rect(@x * @cell_size, @y * @cell_size, @cell_size, @cell_size, @color)
    end

    # def self.random_color
    #   red   = rand(100..175)
    #   green = rand(100..175)
    #   blue  = rand(100..175)
    #   alpha = 250#rand(200..255)

    #   Gosu::Color.rgba(red, green, blue, alpha)
    # end
  end
end