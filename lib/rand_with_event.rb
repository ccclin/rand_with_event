require "rand_with_event/line_function"
require "rand_with_event/input_inject"
require "rand_with_event/version"

module RandWithEvent
  MAX_ORDER = 1000.0

  class Main
    attr_reader :line_function, :input, :random, :function_b

    def initialize(array, options = {})
      @input = array
      $line_function ||= LineFunction.new(input, options)
      @line_function = $line_function
      @function_b = line_function.b.to_a.flatten
      @random = get_random
    end

    def output
      index_number = function_b.each_with_index.inject(0) do |total, (item, index)|
        total += item * ( random ** index )
      end.ceil

      input[:index_number]
    end

    private

    def get_random
      rand_max = line_function.input_inject.total_weights * MAX_ORDER
      (rand(1..rand_max) / MAX_ORDER).round(3)
    end
  end
end
