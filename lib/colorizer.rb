module ScreenSaver
  class Colorizer
    def initialize(value: nil, min:, max:)
      value ||= rand(min..max)
      @value, @min, @max = value, min, max

      @ascending = rand(0..1) == 1
    end

    def value
      @value
    end

    def update
      if @ascending
        @value += 1

        @ascending = false if @value >= @max
      else
        @value -= 1

        @ascending = true if @value <=  @min
      end
    end
  end
end