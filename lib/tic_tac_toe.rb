def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
]

# user_input = gets.chomp

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  spots_filled = 0
  board.each do |spot|
    if spot == "X" || spot == "O"
      spots_filled += 1
    end
  end
  return spots_filled
end


def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  game_winner = nil
  WIN_COMBINATIONS.each do |winning_set_arr|
    if winning_set_arr.all? {|num| board[num] == "X"}
      game_winner = winning_set_arr
    elsif winning_set_arr.all? {|num| board[num] == "O"}
      game_winner = winning_set_arr
    else
      false
    end
  end
  if game_winner == nil
    false
  elsif game_winner != nil
    game_winner
  end
end

def full?(board)
  board.all? {|spot| spot == "X" || spot == "O"}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  if won?(board)
    true
  elsif draw?(board)
    true
  elsif full?(board)
    true
  end
end

def winner(board)
  game_winner = nil
    WIN_COMBINATIONS.each do |winning_arr|
      if winning_arr.all? {|letter| board[letter] == "X"}
        game_winner = "X"
      elsif winning_arr.all? {|letter| board[letter] == "O"}
        game_winner = "O"
      else
    end
  end
  return game_winner
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
