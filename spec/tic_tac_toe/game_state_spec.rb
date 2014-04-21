require 'spec_helper'

describe TicTacToe::GameState do
  let(:game_state) { TicTacToe::GameState.new }
  it "responds with a 9 element array to #current_state" do
    expect(game_state.current_state.size).to eq(9)


  end
end


