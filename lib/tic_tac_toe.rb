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

def move(board, index, token)
  #current_player = "X"
  board[index] = token
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
      board.count("O") + board.count("X")
end

def current_player(board)
 turn_count(board).odd? ? "O" : "X"
end

def position_taken?(board, index)  #Helper Method
  !(board[index].nil? || board[index] == " ")
end

WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # 1st column
  [1,4,7], # 2nd column
  [2,5,8], # 3rd column
  [0,4,8], # diagonal one
  [2,4,6]  # diagonal two
]

def won?(board)
  WIN_COMBINATIONS.find do |win_combination|
  # win_combination is a 3 element array of indexes that compose a win, [0,1,2]
  # grab each index from the win_combination that composes a win.
  board[win_combination[0]] == board[win_combination[1]] &&
  board[win_combination[1]] == board[win_combination[2]] &&
  position_taken?(board, win_combination[0])
end
end

def full?(board)
   board.all? {|board| board== "X"|| board== "O"}
  end

def draw?(board)
   full?(board) && !won?(board)
end

def over?(board)
   won?(board) || full?(board)
end

def winner(board)
 if win_row = won?(board)
  board[win_row[0]]
end
end

def play(board)
    until over?(board) || draw?(board)
       turn(board)
    end
      if won?(board)
        puts "Congratulations #{winner(board)}!"
      elsif draw?(board)
        puts "Cat's Game!"
      end
    end
