module TicTacToe
  class Martee

    def initialize(game_state)
      @game_state = game_state
    end

    def move!
      actions = [ 
	:win!, 
	:block!,
	:fork!,
	:block_fork!,
	:center!,
	:oppisite_corner!,
	:corner!,
	:side! 
      ]
      actions.each do |action|
	break if send(action)
      end
    end


    def center!
      if game_state.empty?(1, 1)
	game_state.nought!(1, 1)
	return true
      end
      return false
    end

    def block_fork!
      game_state.terminal_space_sets.each do |space_set|
	if space_set.one? { |space| game_state.nought?(*space) } &&
	  space_set.count { |space| game_state.empty?(*space) } == 2

	  target_space = space_set.find do |space|
	    opp_space = space_set.find do |s|
	      s != space && game_state.empty?(*s)
	    end
	    opp_space && game_state.empty?(*space) &&
	      does_not_create_opponent_fork(opp_space)
	  end
	  if target_space
	    game_state.nought!(*target_space)
	    return true
	  end
	end
      end
      return false
    end

    def does_not_create_opponent_fork(space)

      sets_containing_space = game_state.terminal_space_sets.select do |space_set|
	space.in? space_set
      end
      sets_containing_space.each do |outer_space_set|
	sets_containing_space.each do |inner_space_set|
	  next unless outer_space_set != inner_space_set
	  unsafe = [ outer_space_set, inner_space_set ].all? do |opp_space_set|
	    opp_space_set.one? { |s| game_state.cross?(*s) } &&
	      opp_space_set.count { |s| game_state.empty?(*s) } == 2
	  end
	  return false if unsafe
	end
      end
      return true
    end

    def fork!
      game_state.terminal_space_sets.each do |outer_space_set|
	game_state.terminal_space_sets.each do |inner_space_set|
	  next if outer_space_set == inner_space_set
	  next unless outer_space_set.one? { |space| space.in? inner_space_set }
	  next unless outer_space_set.one? { |space| game_state.nought?(*space) } 
	  next unless inner_space_set.one? { |space| game_state.nought?(*space) } 
	  next unless outer_space_set.count { |space| game_state.empty?(*space) } == 2
	  next unless inner_space_set.count { |space| game_state.empty?(*space) } == 2
	  target_space = outer_space_set.find do |space| 
	    space.in?(inner_space_set) && game_state.empty?(*space)
	  end
	  next unless target_space
	  game_state.nought!(*target_space)
	  return true
	end
      end
      return false
    end

    def center!
      if game_state.empty?(1, 1)
	game_state.nought!(1, 1)
	return true
      end
    end

    def oppisite_corner!
      if game_state.cross?(0, 0) && game_state.empty?(2, 2)
	game_state.nought!(2, 2)
	return true
      elsif game_state.cross?(2, 2) && game_state.empty?(0, 0)
	game_state.nought!(0, 0)
	return true
      elsif game_state.cross?(0, 2) && game_state.empty?(2, 0)
	game_state.nought!(2, 0)
	return true
      elsif game_state.cross?(2, 0) && game_state.empty?(0, 2)
	game_state.nought!(0, 2)
	return true
      end
      return false
    end

    def corner!
      [ [0, 0], [0, 2], [2, 0], [2, 2] ].each do |x, y|
	if game_state.empty?(x, y)
	  game_state.nought!(x, y)
	  return true
	end
      end
      return false
    end

    def side!
      [ [1, 0], [0, 1], [2, 1], [1, 2] ].each do |x, y|
	if game_state.empty?(x, y)
	  game_state.nought!(x, y)
	  return true
	end
      end
      return false
    end

    def block!
      game_state.terminal_space_sets.each do |space_set|
	if space_set.count { |x, y| game_state.cross?(x, y) } == 2 && 
	  space_set.one? { |x, y| game_state.empty?(x, y) }
	  space = space_set.find { |space| game_state.empty?(*space) }
	  game_state.nought!(*space)
	  return true
	end
      end
      return false
    end

    def win!
      game_state.terminal_space_sets.each do |space_set|
	if space_set.count { |x, y| game_state.nought?(x, y) } == 2 && 
	  space_set.one? { |x, y| game_state.empty?(x, y) }
	  space = space_set.find { |space| game_state.empty?(*space) }
	  game_state.nought!(*space)
	  return true
	end
      end
      return false
    end

    attr_reader :game_state

  end
end
