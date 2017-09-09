# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # Bottom row
  [0,3,6],  # First columns
  [1,4,7],  # Second columns
  [2,5,8],  # Third columns
  [0,4,8],  # Left diagonal
  [2,4,6]  # Right diagonal
]


def display_board(board)
   puts " #{board[0]} | #{board[1]} | #{board[2]} "
   puts "-----------"
   puts " #{board[3]} | #{board[4]} | #{board[5]} "
   puts "-----------"
   puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


def input_to_index(input)
   input.to_i - 1
end


def move(array,position,char)
   array[position] = char
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
   if valid_move?(board,index)
     move(board,index,current_player(board))
     display_board(board)
   else
       turn(board)
   end
 end


 def turn_count(board)
    counter = 0
    board.each do |place|
    if place != " "
        counter += 1
      end
    end
    return counter
  end


def current_player(board)
     current_turn = turn_count(board).to_i
     if current_turn %2 == 0
       return "X"
     elsif current_turn %2 != 0
       return "O"
     end
end


def won?(board)

  WIN_COMBINATIONS.any? do |win_combination|
  win_index_1 = win_combination[0]
  win_index_2 = win_combination[1]
  win_index_3 = win_combination[2]

  position_1 = board[win_index_1]
  position_2 = board[win_index_2]
  position_3 = board[win_index_3]

  if position_1 == "X" && position_2 == "X" && position_3 == "X"
    return win_combination
  elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
    return win_combination
  else
    false
  end
 end
end


def full?(board)
   board.none? do |index|
     index == " "
   end
end


def draw?(board)
  full?(board) && !won?(board)
end


def over?(board)
    if draw?(board) || won?(board) || full?(board)
        true
    else
        false
    end
end


def winner(board)
   winner= won?(board)
   if won?(board) == false
     nil
   elsif board[winner[0]] == "X" && board[winner[1]] == "X" && board[winner[2]] == "X"
     return "X"
   elsif board[winner[0]] == "O" && board[winner[1]] == "O" && board[winner[2]] == "O"
     return "O"
   end
 end


def play(board)
    while !over?(board)
        turn(board)
    end

        if draw?(board)
          puts "Cat's Game!"
            end
        if winner(board) == "X"
          puts "Congratulations X!"
        elsif winner(board) == "O"
          puts "Congratulations O!"
        end
end
