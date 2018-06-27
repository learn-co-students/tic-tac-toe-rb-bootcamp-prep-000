WIN_COMBINATIONS = [ [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6] ]


def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


def input_to_index(user_input)
  user_input.to_i - 1
end


def move(board, index, player_token)
  board[index] = player_token
end


def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end


def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end


def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    player_token = current_player(board)
    move(board, index, player_token)
    display_board(board)
  else
    turn(board)
  end
end


def turn_count(board) 
  move_count = 0
  board.each do |position|
    if position == "X" || position == "O"
    move_count += 1
    end
  end
  puts move_count
  return move_count
end


def current_player(board)
  move_count = turn_count(board)
  if move_count % 2 == 0
    "X"
  else
    "O"
  end
end


def won?(board)
win_combo_length = WIN_COMBINATIONS.length - 1
	for a in 0..win_combo_length
	win_combo= WIN_COMBINATIONS[a]
	check_board = []
		for i in 0..2
		check_board.push(board[win_combo[i]])
		i += 1
		end
			if check_board.all? { |elements| elements == "X"}
				return win_combo
			elsif check_board.all? { |elements| elements == "O"}
				return win_combo 
			end
			a += 1
	end
	if board.any? { |elements| elements != " "}
  else
    return false
	end
end


def full?(board)
    if board.any? { |markers| markers == " "}
      return false
    else 
      return true
  end
end


def draw?(board)
  if won?(board).kind_of?(Array) == false && full?(board) == true
    return true
  else
    return false
  end
end


def over?(board)
  if draw?(board) == true
    return true
  elsif won?(board).kind_of?(Array) == true
  return true
  elsif full?(board) == false 
    return false
end
end


def winner(board)
  won_combo = won?(board)   
  if won?(board) == nil
    return nil
  elsif board[won_combo[0]] == "X"
    return "X"
  elsif board[won_combo[0]] == "O"
    return "O"
  end
end


def play(board)

until (over?(board)==true)
turn(board)
end
  if winner(board) == "X"
  puts "Congratulations X!"
elsif winner(board) == "O"
  puts "Congratulations O!"
elsif draw?(board) == true
  puts "Cat's Game!"
end
end
