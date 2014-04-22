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

  context "when martee can fork" do
    let(:game_state) do
      game_state = TicTacToe::GameState.new
      game_state.nought!(0, 0)
      game_state.nought!(1, 2)
      game_state.cross!(0, 2)
      game_state
    end
    let(:martee) { TicTacToe::Martee.new(game_state) }
    it "forks at (1, 1) or (1, 0)" do
      martee.fork!
      expect(game_state.nought?(1, 1) || game_state.nought?(1, 0)).to be_true
    end
  end

  context "when martee block fork" do
    let(:game_state) do
      game_state = TicTacToe::GameState.new
      game_state.cross!(0, 0)
      game_state.cross!(1, 2)
      game_state.nought!(0, 2)
      game_state
    end
    let(:martee) { TicTacToe::Martee.new(game_state) }
    it "blocks fork at (1, 1) or (1, 0)" do
      martee.block_fork!
      expect(game_state.nought?(1, 1) || game_state.nought?(1, 0)).to be_true
    end
  end

  context "when the center space is open" do 
    let(:game_state) { TicTacToe::GameState.new }
    let(:martee) { TicTacToe::Martee.new(game_state) }
    it "takes the center space" do
      martee.center!
      expect(game_state.nought?(1, 1)).to be_true
    end
  end

end
