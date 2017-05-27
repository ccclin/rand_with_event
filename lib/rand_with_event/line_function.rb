require "matrix"

module RandWithEvent
  class LineFunction
    attr_reader :input, :order, :a, :a_t, :a_t_a_inv, :y, :b, :input_inject

    def initialize(input_array, options = {})
      @input = input_array
      @order = options[:order] || 3
      @input_inject = InputInject.new(input)

      @a = weights_to_matrix
      @a_t = a.transpose
      @a_t_a_inv = (a_t * a).inv
      @y = index_to_matrix
      @b = a_t_a_inv * a_t * y
    end

    private

    def weights_to_matrix
      Matrix.rows(matrix_ready)
    end

    def index_to_matrix
      Matrix.columns([(1..input.length).to_a])
    end

    def matrix_ready
      min_order = [order, input.length].min
      weights = input_inject.output

      weights.map do |item|
        min_order.times.inject([]) do |array, time|
          array << item ** time
        end
      end
    end
  end
end
