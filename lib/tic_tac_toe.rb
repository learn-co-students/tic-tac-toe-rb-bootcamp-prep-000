# define winning winning combinations
WIN_COMBINATIONS = [
   [0,1,2],
   [3,4,5],
   [6,7,8],
   [0,3,6],
   [1,4,7],
   [2,5,8],
   [0,4,8],
   [6,4,2]
]

def play(board)

end

def display_board(board)
   puts
   puts " #{board[0]} | #{board[1]} | #{board[2]} "
   puts "-----------"
   puts " #{board[3]} | #{board[4]} | #{board[5]} "
   puts "-----------"
   puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def position_taken?(board, position)
   if board[position].strip == ""
      false
   end
end

def valid_move?(board, position)

end

def input_to_index(input)
   input.to_i
end

def move(board, position, player)

end

def turn

end

def turn_count(board)
   
end

def won?(board)

end

def current_player(board)

end

def full?(board)

end

def draw?(board)

end

def over?(board)

end

def winner(board)

end
