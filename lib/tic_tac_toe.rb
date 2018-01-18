# Variables

board = [" "," "," "," "," "," "," "," "," "]

WIN_COMBINATIONS = [
  [0, 1, 2], #top_row_win
  [3, 4, 5], #middle_row_win
  [6, 7, 8], #bottom_row_win
  [0, 3, 6], #left_column_win
  [1, 4, 7], #middle_column_win
  [2, 5, 8], #right_column_win
  [0, 4, 8], #left_diag_win
  [6, 4, 2] #right_diag_win
]


#Helper methods

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} \n-----------\n #{board[3]} | #{board[4]} | #{board[5]} \n-----------\n #{board[6]} | #{board[7]} | #{board[8]} \n"
end


def input_to_index(input)
  input.to_i - 1
end



def move(board, index, player_token)
    #player_token = current_player(board)
    board[index] = player_token
  end



def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end



def won?(board)

  if WIN_COMBINATIONS.each do |win|

     if win.all? {|x| board[x] == "X"}
      return win

     elsif win.all? {|o| board[o] == "O"}
       return win

     end
   end

    else
      return false

  end
end


def full?(board)
  board.all? {|filled| filled == "X" || filled == "O"}
end



def draw?(board)
if won?(board) && full?(board) || !full?(board)
  return false
else
  return true

  end
end



def over?(board)
  if draw?(board) == true || won?(board)
    return true
  else
    false

  end
end


def winner(board)
  x_won = []
  o_won = []

  board.each do |count|
      if count == "X"
        x_won << count
      elsif count == "O"
        o_won << count
      end
  end

  if o_won.length > x_won.length
    return "O"

  elsif (x_won.length > o_won.length) && won?(board) != false
    return "X"

  else
    return nil

  end
end


def valid_move?(array, index)
  if !position_taken?(array, index) && checkSpace(index)
    return true
  else
    return false
  end
end


def checkSpace(index)
  if index == 0
    return true
  elsif index == 1
    return true
  elsif index == 2
    return true
  elsif index == 3
    return true
  elsif index == 4
    return true
  elsif index == 5
    return true
  elsif index == 6
    return true
  elsif index == 7
    return true
  elsif index == 8
    return true
  else
    return false
  end
end


def turn(board)

  puts "Please enter 1-9:"
  input = gets.strip
  input = input_to_index(input)
  #player_token = current_player()

  if !valid_move?(board, input)
        turn(board)
    end
    move(board, input, current_player(board))
    display_board(board)

 end


 def turn_count(board)
   count = 0
   board.each do |turn|
     if turn == "X" || turn == "O"
       count+= 1
     end
   end
   return count
 end


 def current_player(board)
   if turn_count(board) % 2 != 0
     return "O"
   else
     return "X"

   end
 end


def play(board)
#loops until the game is over

    while !over?(board)
      turn(board)
    end

#When game is over, it tells players who won (or whether it was a draw)
    if over?(board)

      if draw?(board)
      puts"Cat's Game!"

    elsif winner(board) == "X"
          puts "Congratulations X!"

      else
          puts "Congratulations O!"

        end
    end
end
