module ScreenSaver
  class Window < Gosu::Window
    def initialize
      super(Gosu.screen_width, Gosu.screen_height, true)

      @renderer = Renderer.new(cell_size: 32)
      if ARGV[0] && File.exist?(ARGV[0])
        @frame    = Frame.new(image: Gosu::Image.new(ARGV[0]), renderer: @renderer)
        @renderer.add_frame(@frame)
      end
    end

    def draw
      @renderer.draw
    end

    def update
      @renderer.update
    end
  end
end