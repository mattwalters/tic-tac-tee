require 'spec_helper'

describe TicTacToe::Martee do
  let(:martee) { TicTacToe::Martee.new }

  context "after opening cross at center" do
    let(:game_state) do 
      game_state = TicTacToe::GameState.new
      game_state.cross!(1, 1)
      game_state
    end
    it "takes corner space" do 
      martee.move!(game_state)
      corners = [ [0, 0], [2, 0], [0, 2], [2, 2] ]
      expect(corners.one? { |x, y| game_state.nought?(x, y) }).to be_true
    end
  end
  context "after opening cross anywhere else" do 
    let(:game_state) { TicTacToe::GameState.new }
    ALL_SPACES.each do |x, y|
      unless x == 1 && y == 1
	it "takes the center position" do 
	  game_state.cross!(x, y)
	  martee.move!(game_state)
	  expect(game_state.nought?(1, 1)).to be_true
	end
      end
    end
  end
end
