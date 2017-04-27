#learn open tic-tac-toe-rb-bootcamp-prep-000
# Helper Methods
def display_board(arrayBoard)
  puts " #{arrayBoard[0]} | #{arrayBoard[1]} | #{arrayBoard[2]} "
  puts "-----------"
  puts " #{arrayBoard[3]} | #{arrayBoard[4]} | #{arrayBoard[5]} "
  puts "-----------"
  puts " #{arrayBoard[6]} | #{arrayBoard[7]} | #{arrayBoard[8]} \n\n"
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def current_player(arrayBoard)
  turns_num = turn_count(arrayBoard)
  if(turns_num%2 == 1 && turns_num != 0)
    return "O"
  else
    return "X"
  end
end

def turn_count(arrayBoard)
  counter = 0
  arrayBoard.each {|place|
    if(place != " " && place != "" && place != nil)
      counter += 1
    end
    }
    return counter
end

def move(arrayBoard, index, current_player)
  arrayBoard[index] = current_player
end

def position_taken?(arrayBoard, location)
  arrayBoard[location] != " " && arrayBoard[location] != ""
end

def valid_move?(arrayBoard, index)
  index.between?(0,8) && !position_taken?(arrayBoard, index)
end

def turn(arrayBoard)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if(valid_move?(arrayBoard, index))
    current_playerXorO = current_player(arrayBoard)
    move(arrayBoard, index , current_playerXorO)
    display_board(arrayBoard)
  else
    turn(arrayBoard)
  end
end

# Define your play method below
def play(arrayBoard)
  i=0
  while i < 9
    if(won?(arrayBoard) != false || (full?(arrayBoard) && won?(arrayBoard)))
      puts "Congratulations #{winner(arrayBoard)}!"
      return
    elsif(over?(arrayBoard))
      if(draw?(arrayBoard))
        puts "Cats Game!"
        return
      end
    else
      turn(arrayBoard)
    end
    i += 1
  end
end

WIN_COMBINATIONS = [
  [0,1,2], #top_row_win
  [3,4,5], #mid_row_win
  [6,7,8], #bot_row_win
  [0,3,6], #left_colom_win
  [1,4,7], #mid_colom_win
  [2,5,8], #right_colom_win
  [0,4,8], #top_left_bot_right_diagonla_win
  [2,4,6]  #top_right_bot_left_diagonla_win
]

def won?(arrayBoard)
  WIN_COMBINATIONS.each { |win_com|
  if(win_com.all? {|index| arrayBoard[index] == "X" || arrayBoard[index] == "x"})
    return win_com
  elsif(win_com.all? {|index| arrayBoard[index] == "O" || arrayBoard[index] == "o"})
    return win_com
  end
  }
  return false
end

def full?(arrayBoard)
  arrayBoard.each { |element|
    if( element == nil || element == " " || element == "")
      return false
    end
  }
  return true
end

def draw?(arrayBoard)
  full = full?(arrayBoard)
  won = !won?(arrayBoard)
  if(won && full)
    return true
  end
  return false
end

def over?(arrayBoard)
  if((full?(arrayBoard) && won?(arrayBoard)) || draw?(arrayBoard))
    return true
  end
end

def winner(arrayBoard)
  WIN_COMBINATIONS.each { |win_com|
  if(win_com.all? {|index| arrayBoard[index] == "X" || arrayBoard[index] == "x"})
    return "X"
  elsif(win_com.all? {|index| arrayBoard[index] == "O" || arrayBoard[index] == "o"})
    return "O"
  end
  }
  return nil
end
