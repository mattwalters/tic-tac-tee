class WelcomeController < ApplicationController

  def index 
  end

  def update
    client_game_state = params['gameState']
    outgoing_state = { }

    game_state = create_game_state(client_game_state)
    martee = TicTacToe::Martee.new(game_state)
    martee.move!
    render json: create_outgoing_game_state(game_state)
  end

  private 
  def create_outgoing_game_state(game_state)
    outgoing_state = { }
    if game_state.winner
      outgoing_state[:winner] = game_state.winner
    else
      (0...3).each do |x|
	(0...3).each do |y|
	  value = game_state.current_state[x][y]
	  out = if value == :nought
		  'O'
		elsif value == :cross
		  'X'
		else
		  ' '
		end
	  outgoing_state["#{x}x#{y}"] = out
	end
      end
    end
    outgoing_state
  end

  def create_game_state(client_game_state)
    game_state = TicTacToe::GameState.new
    client_game_state.each do |pos, val|
      x, y = pos.split('x').map(&:to_i)
      if val == 'X'
	game_state.cross!(x, y)
      elsif val == 'O'
	game_state.nought!(x, y)
      end
    end
    game_state
  end

end
