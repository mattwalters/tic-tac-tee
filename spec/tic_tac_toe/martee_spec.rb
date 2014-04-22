require 'spec_helper'

describe TicTacToe::Martee do
  let(:martee) { TicTacToe::Martee.new }

  context "when martee has a winning move" do
    let(:game_state) { TicTacToe::GameState.new }

    TERMINAL_SPACE_SETS.each do |space_set|
      3.times do |n|
	it "wins" do 
	  space_set.each_with_index do |(x, y), i|
	    game_state.nought!(x, y) unless n == i
	  end
	  expect(game_state.winner).to be_nil
	  martee.move!(game_state)
	  expect(game_state.winner).to eq(:nought)
	end
      end
    end
  end
end

