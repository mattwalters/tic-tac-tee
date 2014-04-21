require 'spec_helper'

describe TicTacToe::GameState do

  context "when game_state is still in initial state" do 
    let(:game_state) { TicTacToe::GameState.new }

    it "responds with a 3x3 array to #current_state" do
      expect(game_state.current_state.size).to eq(3)
      3.times { |n| expect(game_state.current_state[n].size).to eq(3) }
    end

    it "responds true to all empty?(x, y)" do
      (0...3).to_a.product((0...3).to_a).each do |x, y|
        expect(game_state.empty?(x, y)).to be_true
      end
    end

    it "responds false to all cross?(x, y)" do
      (0...3).to_a.product((0...3).to_a).each do |x, y|
        expect(game_state.cross?(x, y)).to be_false
      end
    end
    it "responds false to all nought?(x, y)" do
      (0...3).to_a.product((0...3).to_a).each do |x, y|
        expect(game_state.nought?(x, y)).to be_false
      end
    end
    it "responds false to terminal_state?" do
      expect(game_state.terminal_state?).to be_false
    end
    it "it responds nil to winner" do 
      expect(game_state.winner).to be_nil
    end
  end

end


