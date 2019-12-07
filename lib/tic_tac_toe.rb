
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end
#
def input_to_index(index)

  return index.to_i-1
end
#
def move(board,index, current_player)
  board[index] = current_player
  return board
end
#
def position_taken?(board, index)
  return !(board[index].nil? || board[index]==" ")
end
#
def valid_move?(board, index)
  if index>=0 && index <=9
    if board[index] == " " || board[index] == "" || board[index] ==  nil
      return true
    else
      return false
    end
  else
    return false
  end
end
#
# def turn(board)
#   puts "Please enter 1-9:"
#   index = gets.strip
#   index = input_to_index(index.strip)
#   valid = valid_move?(board, index)
#   current_player = current_player(board)
#   if valid
#     move(board, index,current_player)
#     display_board(board)
#   elsif
#     until valid
#       puts "Please enter 1-9:"
#       index = gets.chomp
#       index = input_to_index(index.chomp)
#       valid = valid_move?(board, index)
#       if valid
#         move(board, index,current_player)
#         display_board(board)
#       end
#     end
#     move(board, index,current_player)
#     display_board(board)
#   end
# end
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  current_player = current_player(board)
  if valid_move?(board, index)
    move(board, index, current_player)
    display_board(board)
  else
    turn(board)
  end
end
#
def turn_count(board)
  count = 0
  board.each do |i|
    if i!= " "
      count+=1
    end
  end
  return count
end
#
def current_player(board)
  return turn_count(board)%2 == 0 ? move="X" : move="O"
end
#
def won?(board)
  if board.all?(" ")
    return false
  end

  WIN_COMBINATIONS.each do |win_combination|

    # if board.none?(" ") && board[win_combination[0]] != board[win_combination[1]]
    #   return false
    # end

    all_valid = win_combination.none? do |i|
      board[i] == " "
    end

    if board[win_combination[0]] == board[win_combination[1]] && board[win_combination[1]] == board[win_combination[2]] && all_valid
      return win_combination
    end
  end
  return false
end
#
#
def full?(board)
  return board.none?(" ")
end
#
def draw?(board)
  won = won?(board)
  full = full?(board)
  if won == true
    return false
  elsif won == false && full == true
    return true
  end
  # if won?(board) == false && full?(board)
  #   return true
  # elsif won?(board) == false && board.none?(" ")
  #   return false
  # elsif won?(board).class == Array
  #   return false
  # end
end
#
def over?(board)
  if full?(board) || draw?(board) || won?(board).class == Array
    return true
  else
    return false
  end
end
#
def winner(board)
  if won?(board)==false
    return nil
  else
    return board[won?(board)[0]]
end
end
#
def play(board)


  over = over?(board)
  won = won?(board)
  draw = draw?(board)
  if over
    if draw
      puts "Cat's Game!"
      return false
    elsif won
      puts "Congratulations #{winner(board)}!"
      return false
    end
  end
  until over
    turn(board)
    over = over?(board)
    won = won?(board)
    if won?(board)
      puts "Congratulations #{winner(board)}!"
      return false
    elsif(draw?(board))
      puts "Cat's Game!"
      return false
    end
  end

end
