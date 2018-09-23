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

 def input_to_index(user_input)
  user_input.to_i - 1
end

 def player_move(board, index, current_player)
  board[index] = current_player
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
    player_move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

 def turn_count(board)
  turn_count = 0
  board.each do |index|
    if index == "X" or index == "O"
    turn_count += 1
    end
  end
  return turn_count
end

 def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end  
end

 def won?(board)
  combination = 0
  while combination < WIN_COMBINATIONS.length
    current_combination = WIN_COMBINATIONS[combination]
    xwin = current_combination.all? {|position| board[position] == "X"}
    owin = current_combination.all? {|position| board[position] == "O"}
    if xwin == true || owin == true
      return current_combination
    end
    combination += 1
  end
  return false
end

  
def full?(board)
  board.all? {|index| index == 'X' || index == 'O'}
end

 def draw?(board)
  won?(board) == false && full?(board) == true
end  

 def over?(board)
  won?(board) || draw?(board) || full?(board)
end

 def winner(board)
    combination = 0
    while combination < WIN_COMBINATIONS.length
      current_combination = WIN_COMBINATIONS[combination]
      xwin = current_combination.all? {|position| board[position] == "X"}
      owin = current_combination.all? {|position| board[position] == "O"}
      if xwin == true
        return "X"
      elsif owin == true 
        return "O"
      else
        false
      end
      combination += 1
    end
end

 def play(board)
  while over?(board) == false
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end  
end