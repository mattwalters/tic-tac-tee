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
	  martee.move!
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
	  martee.move!  
	  expect(space_set.count { |space| game_state.cross?(*space) }).to eq(2)
	  expect(space_set.one? { |space| game_state.nought?(*space) }).to be_true
	end
      end
    end
  end


end

