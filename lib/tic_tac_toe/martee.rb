module TicTacToe
  class Martee

    def initialize(game_state)
      @game_state = game_state
    end

    def move!
      if can_win?
	win!
      elsif can_block?
	block!
      elsif can_fork?
	fork!
      end
    end

    def can_center?
      game_state.empty?(1, 1)
    end

    def center!
      game_state.nought!(1, 1)
    end

    def can_block_fork?
      game_state.terminal_space_sets.each do |outer_space_set|
	game_state.terminal_space_sets.each do |inner_space_set|
	  next if outer_space_set == inner_space_set
	  if outer_space_set.one? { |space| (space.in? inner_space_set) && 
			     game_state.empty?(*space) }
	    if outer_space_set.one? { |space| game_state.cross?(*space) } &&
	      inner_space_set.one? { |space| game_state.cross?(*space) } &&
	      outer_space_set.count { |space| game_state.empty?(*space) } == 2 &&
	      inner_space_set.count { |space| game_state.empty?(*space) } == 2
	      return true
	    end
	  end
	end
      end
      false
    end
    def block_fork!
      game_state.terminal_space_sets.each do |outer_space_set|
	game_state.terminal_space_sets.each do |inner_space_set|
	  if outer_space_set.one? { |space| (space.in? inner_space_set) && 
			     game_state.empty?(*space) }
	    if outer_space_set.one? { |space| game_state.cross?(*space) } &&
	      inner_space_set.one? { |space| game_state.cross?(*space) } &&
	      outer_space_set.count { |space| game_state.empty?(*space) } == 2 &&
	      inner_space_set.count { |space| game_state.empty?(*space) } == 2
	      # find the shared empty space
	      target_space = outer_space_set.find { |space| (space.in? inner_space_set) &&
					     game_state.empty?(*space) }
	      game_state.nought!(*target_space)
	      return
	    end
	  end
	end
      end

    end
    def can_fork?
      game_state.terminal_space_sets.each do |outer_space_set|
	game_state.terminal_space_sets.each do |inner_space_set|
	  next if outer_space_set == inner_space_set
	  if outer_space_set.one? { |space| (space.in? inner_space_set) && 
			     game_state.empty?(*space) }
	    if outer_space_set.one? { |space| game_state.nought?(*space) } &&
	      inner_space_set.one? { |space| game_state.nought?(*space) } &&
	      outer_space_set.count { |space| game_state.empty?(*space) } == 2 &&
	      inner_space_set.count { |space| game_state.empty?(*space) } == 2
	      return true
	    end
	  end
	end
      end
      false
    end

    def fork!
      game_state.terminal_space_sets.each do |outer_space_set|
	game_state.terminal_space_sets.each do |inner_space_set|
	  if outer_space_set.one? { |space| (space.in? inner_space_set) && 
			     game_state.empty?(*space) }
	    if outer_space_set.one? { |space| game_state.nought?(*space) } &&
	      inner_space_set.one? { |space| game_state.nought?(*space) } &&
	      outer_space_set.count { |space| game_state.empty?(*space) } == 2 &&
	      inner_space_set.count { |space| game_state.empty?(*space) } == 2
	      # find the shared empty space
	      target_space = outer_space_set.find { |space| (space.in? inner_space_set) &&
					     game_state.empty?(*space) }
	      game_state.nought!(*target_space)
	      return
	    end
	  end
	end
      end
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
