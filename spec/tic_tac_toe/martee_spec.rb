require 'spec_helper'

describe TicTacToe::Martee do 

  TERMINAL_SPACE_SETS.each do |space_set|
    3.times do |n|
      context "when martee has a winning move" do
	let(:game_state) do 
	  game_state = TicTacToe::GameState.new
	  space_set.each_with_index do |(x, y), i|
	    game_state.nought!(x, y) unless n == i
	  end
	  game_state
	end
	let(:martee) { TicTacToe::Martee.new(game_state) }

	it "wins" do 
	  martee.win!
	  expect(game_state.winner).to eq(:nought)
	end
      end
    end
  end

  TERMINAL_SPACE_SETS.each do |space_set|
    3.times do |n|
      context "when opponent has a winning move" do
	let(:game_state) do 
	  game_state = TicTacToe::GameState.new
	  space_set.each_with_index do |(x, y), i|
	    game_state.cross!(x, y) unless n == i
	  end
	  game_state
	end
	let(:martee) { TicTacToe::Martee.new(game_state) }

	it "blocks" do 
	  martee.block!  
	  expect(space_set.count { |space| game_state.cross?(*space) }).to eq(2)
	  expect(space_set.one? { |space| game_state.nought?(*space) }).to be_true
	end
      end
    end
  end

  TERMINAL_SPACE_SETS.each do |outer_space_set|
    TERMINAL_SPACE_SETS.each do |inner_space_set|
      unless outer_space_set == inner_space_set
	if outer_space_set.one? { |space| space.in? inner_space_set }
	  context "when martee can fork" do
	    let(:game_state) do
	      game_state = TicTacToe::GameState.new
	      outer_space = outer_space_set.find { |space| !space.in? inner_space_set }
	      inner_space = inner_space_set.find { |space| !space.in? outer_space_set }
	      game_state.nought!(*outer_space)
	      game_state.nought!(*inner_space)
	      game_state
	    end
	    let(:martee) { TicTacToe::Martee.new(game_state) }

	    it "forks" do 
	      expect(martee.can_fork?).to be_true
	      # having a hard time getting this right...
	    end
	  end
	end
      end
    end
  end


  TERMINAL_SPACE_SETS.each do |outer_space_set|
    TERMINAL_SPACE_SETS.each do |inner_space_set|
      unless outer_space_set == inner_space_set
	if outer_space_set.one? { |space| space.in? inner_space_set }
	  context "when martee can block a fork" do
	    let(:game_state) do
	      game_state = TicTacToe::GameState.new
	      outer_space = outer_space_set.find { |space| !space.in? inner_space_set }
	      inner_space = inner_space_set.find { |space| !space.in? outer_space_set }
	      game_state.cross!(*outer_space)
	      game_state.cross!(*inner_space)
	      game_state
	    end
	    let(:martee) { TicTacToe::Martee.new(game_state) }

	    it "block fork" do 
	      expect(martee.can_block_fork?).to be_true
	      # having a hard time getting this right...
	    end
	  end
	end
      end
    end
  end

  context "when center is open" do
    let(:game_state) { TicTacToe::GameState.new }
    let(:martee) { TicTacToe::Martee.new(game_state) }
    it "takes the center" do 
      expect(martee.can_center?).to be_true
      martee.center!
    end
  end

end
