
WIN_COMBINATIONS = [
  [0,1,2], #Top Row
  [3,4,5], # Middle Row
  [6,7,8], # Bottom Row
  [0,3,6], # Left Column
  [1,4,7], # Middle Column
  [2,5,8], # Right Column
  [0,4,8], # Left Diagonal
  [2,4,6] # Right Diagonal
]

def display_board (board)
# Creates board
puts " #{board[0]} | #{board[1]} | #{board[2]} "
puts "-----------"
puts " #{board[3]} | #{board[4]} | #{board[5]} "
puts "-----------"
puts " #{board[6]} | #{board[7]} | #{board[8]} "

end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board,position,player)
  board[position]= player
end

def position_taken?(board,position)
    board[position].include?("X") || board[position].include?("O")
end

def valid_move?(board,position)
     if position >= 0 && position < 9
       !position_taken?(board,position)
   end
end


def turn(board)

  loop do
    puts "Please enter 1-9"
    user_input = gets.strip.to_i

    if user_input.class == Fixnum
      user_input = input_to_index(user_input)

      if valid_move?(board,user_input)
        move(board,user_input,current_player(board))
        display_board(board)
        break
      end
    end
  end
end

def turn_count(board)
  count = board.reject do |plays|
    plays == " "
  end
   count.length
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def won?(board)
 did_win = false
  WIN_COMBINATIONS.each do |win_combinations|
    winner_array = []
    win_combinations.each do |index|
      winner_array << board[index]
    end
    x = winner_array.all? do |winner|
      winner ==  "X"
    end
    o = winner_array.all? do |winner|
      winner == "O"
    end
    if x || o
      return win_combinations
    end
  end
  did_win
end

def full?(board)
  !board.include?(" ")
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  if winner = won?(board) then board[winner[0]] end
end

def play(board)

 until over?(board)
   turn(board)
 end
 if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat\'s Game!"
  end
end
