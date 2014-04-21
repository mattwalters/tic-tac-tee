module TicTacToe
  class SpaceNotVacantError < StandardError; end
  class IllegalSpaceError < StandardError; end
  class GameState

    def initialize
      @state = (0...3).to_a.map do 
	(0...3).to_a.map do
	  :empty
	end
      end
    end

    def current_state
      state
    end

    def cross!(x, y)
      validate_empty!(x, y)
      validate_in_bounds!(x, y)
      state[x][y] = :cross
    end

    def nought!(x, y)
      validate_empty!(x, y)
      validate_in_bounds!(x, y)
      state[x][y] = :nought
    end

    def empty?(x, y)
      validate_in_bounds!(x, y)
      state[x][y] == :empty
    end
    def cross?(x, y)
      validate_in_bounds!(x, y)
      state[x][y] == :cross
    end
    def nought?(x, y)
      validate_in_bounds!(x, y)
      state[x][y] == :nought
    end
    def terminal_state?
      false
    end
    def winner
      nil
    end

    private 

    def validate_in_bounds!(x, y)
      unless x.in?(0...3) && y.in?(0..3)
	raise IllegalSpaceError, "illegal space: (#{x}, #{y})"
      end
    end
    def validate_empty!(x, y)
      unless empty?(x, y)
        raise SpaceNotVacantError, "(#{x}, #{y}) was #{state[x][y]} not empty" 
      end
    end

    attr_reader :state
  end
end
