module TicTacToe
  class Martee

    def initialize(game_state)
      @game_state = game_state
    end

    def move!
      win! if can_win?
      block! if can_block?
    end

    def can_block?
      game_state.terminal_space_sets.any? do |space_set|
	space_set.count { |x, y| game_state.cross?(x, y) } == 2 && 
	  space_set.one? { |x, y| game_state.empty?(x, y) }
      end
    end

    def block!
      game_state.terminal_space_sets.each do |space_set|
	if space_set.count { |x, y| game_state.cross?(x, y) } == 2 && 
	  space_set.one? { |x, y| game_state.empty?(x, y) }
	  space = space_set.find { |space| game_state.empty?(*space) }
	  game_state.nought!(*space)
	  break
	end
      end

    end

    def can_win?
      game_state.terminal_space_sets.any? do |space_set|
	space_set.count { |x, y| game_state.nought?(x, y) } == 2 && 
	  space_set.one? { |x, y| game_state.empty?(x, y) }
      end
    end
    def win!
      game_state.terminal_space_sets.each do |space_set|
	if space_set.count { |x, y| game_state.nought?(x, y) } == 2 && 
	  space_set.one? { |x, y| game_state.empty?(x, y) }
	  space = space_set.find { |space| game_state.empty?(*space) }
	  game_state.nought!(*space)
	  break
	end
      end
    end

    attr_reader :game_state

  end
end
