module TicTacToe
  class Martee

    def move!(game_state)
      if game_state.empty?(1, 1)
	game_state.nought!(1, 1)
      else
	game_state.nought!(0, 0)
      end
    end

  end
end
