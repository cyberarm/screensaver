module ScreenSaver
  class Tile
    attr_accessor :reserved, :color
    def initialize(x:, y:, cell_size:, reserved: false, color: Gosu::Color::NONE)
      @x, @y, @cell_size = x, y, cell_size
      @reserved = reserved
      @color = color
    end

    def reserved?
      @reserved
    end

    def reserve
      @reserved = true
    end

    def free
      @reserved = false
    end

    def draw
      Gosu.draw_rect(@x * @cell_size, @y * @cell_size, @cell_size, @cell_size, @color)
    end

    def self.random_color
      cr = rand(100..180)
      alpha = 240

      Gosu::Color.rgba(cr, cr, cr, alpha)
    end
  end
end