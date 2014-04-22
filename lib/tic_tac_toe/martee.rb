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
      game_state.terminal_space_sets.each do |outer_space_set|
	game_state.terminal_space_sets.each do |inner_space_set|
	  next if outer_space_set == inner_space_set
	  next unless outer_space_set.one? { |space| space.in? inner_space_set }
	  next unless outer_space_set.one? { |space| game_state.cross?(*space) } 
	  next unless inner_space_set.one? { |space| game_state.cross?(*space) } 
	  next unless outer_space_set.count { |space| game_state.empty?(*space) } == 2
	  next unless inner_space_set.count { |space| game_state.empty?(*space) } == 2
	  # this should be a forkable pair
	  target = outer_space_set.find do |space| 
	    space.in?(inner_space_set) && game_state.empty?(*space)
	  end
	  game_state.nought!(*target_space)
	  return true
	end
      end
      return false
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

    def block_fork!
      game_state.terminal_space_sets.each do |outer_space_set|
	game_state.terminal_space_sets.each do |inner_space_set|
	  next if outer_space_set == inner_space_set
	  next unless outer_space_set.one? { |space| space.in? inner_space_set }
	  next unless outer_space_set.one? { |space| game_state.cross?(*space) } 
	  next unless inner_space_set.one? { |space| game_state.cross?(*space) } 
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
