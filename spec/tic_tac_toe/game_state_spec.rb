require 'spec_helper'

# I think these constants should be helpers
# but I had some trouble getting them to work quickly
# this seems to work for now -- would love some pointers
# on how best to resue code in specs :)
ALL_SPACES = (0...3).to_a.product((0...3).to_a)
ILLEGAL_SPACES = [ -2, -1, 4, 5 ].product([-2, -1, 4, 5 ])
MARKERS = [ :cross, :nought ]

TERMINAL_COLUMNS = [ 
  [ [ 0, 0 ], [ 0, 1 ], [ 0, 2 ] ],
  [ [ 1, 0 ], [ 1, 1 ], [ 1, 2 ] ],
  [ [ 2, 0 ], [ 2, 1 ], [ 2, 2 ] ]
]
TERMINAL_ROWS = [ 
  [ [ 0, 0 ], [ 1, 0 ], [ 2, 0 ] ],
  [ [ 0, 1 ], [ 1, 1 ], [ 2, 1 ] ],
  [ [ 0, 2 ], [ 1, 2 ], [ 2, 2 ] ]
]
TERMINAL_DIAGONALS = [ 
  [ [ 0, 0 ], [ 1, 1 ], [ 2, 2 ] ],
  [ [ 2, 0 ], [ 1, 1 ], [ 0, 2 ] ]
]
TERMINAL_SPACE_SETS = TERMINAL_COLUMNS + TERMINAL_ROWS + TERMINAL_DIAGONALS

describe TicTacToe::GameState do

  context "when game_state is still in initial state" do 
    let(:game_state) { TicTacToe::GameState.new }

    it "responds with a 3x3 array to #current_state" do
      expect(game_state.current_state.size).to eq(3)
      3.times { |n| expect(game_state.current_state[n].size).to eq(3) }
    end
    it "responds true to all empty?(x, y)" do
      ALL_SPACES.each do |x, y|
	expect(game_state.empty?(x, y)).to be_true
      end
    end
    it "responds false to terminal_state?" do
      expect(game_state.terminal_state?).to be_false
    end
    it "it responds nil to winner" do 
      expect(game_state.winner).to be_nil
    end

    MARKERS.each do |marker|
      it "responds false to all #{marker}?(x, y)" do
	ALL_SPACES.each do |x, y|
	  expect(game_state.send("#{marker}?", x, y)).to be_false
	end
      end
      it "can #{marker}!(x, y) for all x,y pairs" do 
	ALL_SPACES.each do |x, y|
	  game_state.send("#{marker}!", x, y)
	  expect(game_state.send("#{marker}?", x, y)).to be_true
	end
      end

      ALL_SPACES.each do |x, y|

	context "when #{marker}!(#{x}x#{y})" do
	  let(:game_state) do 
	    game_state = TicTacToe::GameState.new
	    game_state.send("#{marker}!", x, y)
	    game_state
	  end	
	  it "responds true to ##{marker}?(#{x}, #{y})" do
	    expect(game_state.send("#{marker}?", x, y)).to be_true
	  end
	  it "raises an error if marking to a non-empty space" do
	    expect { game_state.send("#{marker}!", x, y) }.to raise_error(
	      TicTacToe::SpaceNotVacantError
	    )
	  end
	end
      end

      ILLEGAL_SPACES.each do |x, y|
	it "raises an error if marking an illegal space (#{x}, #{y})" do 
	  expect { game_state.send("#{marker}!", x, y) }.to raise_error(
	    TicTacToe::IllegalSpaceError
	  )
	end
      end

      TERMINAL_SPACE_SETS.each do |space_set|
	it "responds true to terminal_state when one marker has #{space_set}" do 
	  space_set.each do |x, y|
	    expect(game_state.terminal_state?).to be_false
	    game_state.send("#{marker}!", x, y)
	  end
	  expect(game_state.terminal_state?).to be_true
	end
	it "should return #{marker} on #winner" do
	  space_set.each do |x, y|
	    expect(game_state.winner).to be_nil
	    game_state.send("#{marker}!", x, y)
	  end
	  expect(game_state.winner).to eq(marker)
	end
      end
    end
  end
end
