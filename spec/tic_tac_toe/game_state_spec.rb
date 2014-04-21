require 'spec_helper'

describe TicTacToe::GameState do

  context "when game_state is still in initial state" do 
    let(:game_state) { TicTacToe::GameState.new }

    it "responds with a 3x3 array to #current_state" do
      expect(game_state.current_state.size).to eq(3)
      expect(game_state.current_state[0].size).to eq(3)
      expect(game_state.current_state[1].size).to eq(3)
      expect(game_state.current_state[2].size).to eq(3)
    end

    it "responds true to all empty?(x, y)" do
      3.times do |x|
	3.times do |y|
	  expect(game_state.empty?(x, y)).to be_true
	end
      end
    end

    it "responds false to all cross?(x, y)" do
      3.times do |x|
	3.times do |y|
	  expect(game_state.cross?(x, y)).to be_false
	end
      end
    end
    it "responds false to all nought?(x, y)" do
      3.times do |x|
	3.times do |y|
	  expect(game_state.nought?(x, y)).to be_false
	end
      end
    end
  end

end


