module TicTacToe
  class GameState

    def current_state
      (0...3).to_a.map do 
	(0...3).to_a.map do
	  :empty
	end
      end
    end
    def empty?(x, y)
      true
    end
    def cross?(x, y)
      false
    end
    def nought?(x, y)
      false
    end
  end
end
