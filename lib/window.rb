module ScreenSaver
  class Window < Gosu::Window
    def initialize
      super(Gosu.screen_width, Gosu.screen_height, true)

      @renderer = Renderer.new(cell_size: 32)
    end

    def draw
      @renderer.draw
    end

    def update
      @renderer.update
    end
  end
end