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

def input_to_index(number)
  index = number.to_i - 1
end

def player_move(board, index, character)
  board[index] = character
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
    puts "That is not a valid move, please try again."
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |cell|
    if cell == "X" || cell == "O"
      count += 1 
    end
  end
  count
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.detect do |win_combination|
    position_taken?(board, win_combination[0]) == true && board[win_combination[0]] == board[win_combination[1]] && board[win_combination[1]] == board[win_combination[2]]
  end
end

def full?(board)
  [0,1,2,3,4,5,6,7,8].all?{|index| position_taken?(board, index)}
end

def draw?(board)
  won?(board).nil? && full?(board) == true
end

def over?(board)
  !won?(board).nil? || draw?(board) == true
end

def winner(board)
  if won?(board).nil?
    nil
  else
    board[won?(board).detect{|index| position_taken?(board, index)}]
  end
end

def play(board)
  until over?(board)
    turn(board)
    if won?(board)
      puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
      puts "Cat's Game!"
    end 
  end
  won?(board)
  puts("Congratulations X!")
  won?(board)
  puts("Congratulations O!")
  won?(board)
  puts("Cat's Game!")
end