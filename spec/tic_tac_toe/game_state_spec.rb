require 'spec_helper'

describe TicTacToe::GameState do
  context "when game_state is still in initial state" do 
    let(:game_state) { TicTacToe::GameState.new }

    it "responds with a 9 element array to #current_state" do
      expect(game_state.current_state.size).to eq(9)
    end

    it "puts :empty for each of the 9 elements" do
      expect(game_state.current_state.all? { |space| space == :empty }).to be_true
    end
  end
end


