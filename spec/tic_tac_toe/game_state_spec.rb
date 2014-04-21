require 'spec_helper'

describe TicTacToe::GameState do

  def three_by_three_product
    (0...3).to_a.product((0...3).to_a)
  end

  context "when game_state is still in initial state" do 
    let(:game_state) { TicTacToe::GameState.new }

    it "responds with a 3x3 array to #current_state" do
      expect(game_state.current_state.size).to eq(3)
      3.times { |n| expect(game_state.current_state[n].size).to eq(3) }
    end

    it "responds true to all empty?(x, y)" do
      three_by_three_product.each do |x, y|
        expect(game_state.empty?(x, y)).to be_true
      end
    end

    it "responds false to all cross?(x, y)" do
      three_by_three_product.each do |x, y|
        expect(game_state.cross?(x, y)).to be_false
      end
    end
    it "can cross!(x, y) for all x,y pairs" do 
      three_by_three_product.each do |x, y|
	game_state.cross!(x, y)
	expect(game_state.cross?(x, y)).to be_true
      end
    end
    it "responds false to all nought?(x, y)" do
      three_by_three_product.each do |x, y|
        expect(game_state.nought?(x, y)).to be_false
      end
    end
    it "can nought!(x, y) for all x,y pairs" do 
      three_by_three_product.each do |x, y|
	game_state.nought!(x, y)
	expect(game_state.nought?(x, y)).to be_true
      end
    end
    it "responds false to terminal_state?" do
      expect(game_state.terminal_state?).to be_false
    end
    it "it responds nil to winner" do 
      expect(game_state.winner).to be_nil
    end
    context "when cross moves 1x1" do
      let(:game_state) do 
	game_state = TicTacToe::GameState.new
	game_state.cross!(1, 1)
	game_state
      end	
      it "responds true to #cross?(1, 1)" do
	expect(game_state.cross?(1, 1)).to be_true
      end
      it "responds false to everything but #cross?(1, 1)" do 
	three_by_three_product.each do |x, y|
	  expect(game_state.cross?(x, y)).to be_false unless [ x, y ] == [ 1, 1 ]
	end
      end
      it "raises an error if moving to a non-empty space" do
	expect { game_state.cross!(1, 1) }.to raise_error(TicTacToe::SpaceNotVacantError)
      end
    end
  end

end


