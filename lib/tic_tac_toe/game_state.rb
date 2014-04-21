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
      terminal_space_sets.any? do |space_set|
	space_set.all? do |x, y|
	  cross?(x, y) || nought?(x, y)
	end
      end
    end
    def winner
      markers.each do |marker|
	terminal_space_sets.each do |space_set|
	  return marker if space_set.all? do |x, y|
	    send("#{marker}?", x, y)
	  end
	end
      end
      nil
    end

    private 

    def markers
      [ :cross, :nought ]
    end

    def terminal_columns
      (0...3).map { |x| (0...3).map { |y| [ x, y ] } }
    end
    def terminal_rows
      (0...3).map { |y| (0...3).map { |x| [ x, y ] } }
    end
    def terminal_diagonals
      [ (0...3).map { |n| [ n, n ] }, (0...3).map { |n| [ 2 - n, n ] } ]
    end
    def terminal_space_sets
      terminal_columns + terminal_rows + terminal_diagonals
    end

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
