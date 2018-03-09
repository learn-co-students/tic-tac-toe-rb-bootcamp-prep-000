WIN_COMBINATIONS = [
  #horizontal wins
   [0,1,2],
   [3,4,5],
   [6,7,8],

  #vertical wins
   [0,3,6],
   [1,4,7],
   [2,5,8],

  #diagonal wins
   [0,4,8],
   [2,4,6]

  ] #closes WIN_COMBINATIONS array

board = ["   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   "]

def display_board (board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


def input_to_index (input)
  (input.to_i) - 1
end


def move (board, index, team)
    board [index] = team
end


def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end


def valid_move? (board, index)
  if ( position_taken?(board, index) == false ) && ( index.between?(0,8) )
      return true

  else
      return false
  end
end



def turn(board)

  team = current_player(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)

  if valid_move?(board, index)
    move(board, index, team)
    display_board(board)
  else
    turn(board)
  end
end



def turn_count (board)
    counter = 0
    board.each do |position|

          if position != " "
            counter += 1
          end
    end
    #return counter outside of board.each
    return counter
end


def current_player ( board )
  current_turn = turn_count(board)

      if current_turn % 2 == 0

        return current_turn = "X"

      else

        return current_turn = "O"

      end
end


def won? (board)
  WIN_COMBINATIONS.find do |combo|
    #binding.pry
    board[combo[0]] == board[combo[1]] && #=> true
    board[combo[1]] == board[combo[2]] && # true
    position_taken?(board, combo[0]) #true

    #returns the winning combination (see list above)
  end
end



def full? (board)
  board.none? {|index| index == " "}
end


def draw? (board)
    #WON needs be the first condition in &&

    if  ( won?(board) == nil ) && ( full?(board) == true ) 
       return true

    else
      return false

    end

end


def over? (board)
  #returns *true* if the board has been won, is a draw or full
  if ( won?(board) != nil ) || ( draw?(board) == true ) || ( full?(board) == true )
    return true
  else
    return false
  end
end


def winner (board)
  winning_combo = ( won?(board) )
  if winning_combo != nil
      if ( board[winning_combo[0]] == "X" )
        return "X"
      elsif ( board[winning_combo[0]] == "O" )
        return "O"
      end
  else
    return nil
  end
end


def play (board)
  until over?(board)
      turn(board)
  end #end until over?(board)

  if won?(board)
      puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
      puts "Cat's Game!"
  end #end if/elsif statement

end #end play(board)






