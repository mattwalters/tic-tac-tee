module TicTacToe
  class SpaceNotVacantError < StandardError; end
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
      unless empty?(x, y)
        raise SpaceNotVacantError, "(#{x}, #{y}) was #{state[x][y]} not empty" 
      end
      state[x][y] = :cross
    end

    def nought!(x, y)
      unless empty?(x, y)
        raise SpaceNotVacantError, "(#{x}, #{y}) was #{state[x][y]} not empty" 
      end
      state[x][y] = :nought
    end

    def empty?(x, y)
      state[x][y] == :empty
    end
    def cross?(x, y)
      state[x][y] == :cross
    end
    def nought?(x, y)
      state[x][y] == :nought
    end
    def terminal_state?
      false
    end
    def winner
      nil
    end

    private 

    attr_reader :state
  end
end
