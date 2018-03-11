def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end
def won?(board)
  WIN_COMBINATIONS.each do |combination|
    if (board[combination[0]] == board[combination[1]] && board[combination[1]] == board[combination[2]]) && (board[combination[0]] != " ")
      return combination
    end
  end
  return nil
end
WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
def full?(board)
  board.each do |value|
    if value == " "
      return false
    end
  end
  return true
end
def draw?(board)
  if !(won?(board)) && full?(board)
    return true
  end
  return false
end
def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true
  end
  return false
end
def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  end
  return nil
end
def input_to_index(user_input)
  user_input.to_i - 1
end
def move(board, index, current_player)
  board[index] = current_player
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
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end
def turn_count(board)
  occupied = 0
  board.each do |position|
    if position != " "
      occupied+=1
    end
  end
  return occupied
end
def current_player(board)
  turns = turn_count(board)
  if turns % 2 == 0
    return "X"
  else 
    return "O"
  end
end
def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end









