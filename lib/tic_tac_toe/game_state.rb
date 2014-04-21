module TicTacToe
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
      state[x][y] = :cross
    end

    def empty?(x, y)
      true
    end
    def cross?(x, y)
      state[x][y] == :cross
    end
    def nought?(x, y)
      false
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
