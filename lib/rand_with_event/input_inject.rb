module RandWithEvent
  class InputInject
    attr_reader :output, :total_weights

    def initialize(input_array)
      @output = weights(input_array)
      @total_weights = output.last
    end

    private

    def weights(input)
      input.inject([]) do |array, item|
        array << item[:weights] + array.last.to_i
      end
    end
  end
end
