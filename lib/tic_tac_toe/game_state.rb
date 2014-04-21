module TicTacToe
  class GameState

    def current_state
      (0...3).to_a.map do 
	(0...3).to_a.map do
	  :empty
	end
      end
    end
  end
end
