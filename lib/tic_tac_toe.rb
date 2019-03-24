# Define your WIN_COMBINATIONS constant

WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8], 
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
  ]









def display_board(array)
  puts " #{array[0]} | #{array[1]} | #{array[2]} "
  puts "-----------"
  puts " #{array[3]} | #{array[4]} | #{array[5]} "
  puts "-----------"
  puts " #{array[6]} | #{array[7]} | #{array[8]} "
end





# take the user's input ("1"-"9") and convert it to 
#the index of the board array (0-8). 
#Part of  #move-  updating the board Array passed into it.

def input_to_index(input)
  position = input.to_i - 1     
  # ^ used gets again here, was wrong.. did gets in bin

  # position = position - 1
  return position
  
end




#move method represents a user moving into a position
def move(array, index, current_player)       # was value, changed to current_pl
    array[index] = current_player
    return array     # was return board, threw off the 3rd argument optional test..
  
end





def valid_move? (array, index)

  def position_taken?(array, index)
    if ( array[index] == " " ||  array[index] ==""  || array[index] == nil )
      return FALSE
    else
      return TRUE
    end
  end
  
taken = position_taken?(array, index)
  
  if ( index >= 0  && index < 9  && taken == FALSE )

     #     position_taken?(array, index) == FALSE )
    return TRUE
  else 
    return FALSE
  end 
  
end




# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end




def turn(array)
  puts ("Please enter 1-9:")
  input = gets.strip
  index = input_to_index(input)
  
  if  valid_move?(array, index) == true    # was TRUE @ Mar 1
      move(array, index, current_player(array)) &&   display_board(array) 
      #move(board, index, "X") &&   display_board(board)    # < was this
    else
      #puts "Please enter 1-9:"          # was puts "invalid" not rqd, will ask again when rerun turn
      turn(array)
  end 
  # display_board(board) 
  
end






def turn_count(array)
  counter = 0
  array.each do |space|
    if (space == "O" || space == "X")
    #if (space != " " || space != "")
      counter +=1 
    end
  end
  return counter
end




def current_player(array)
  if ( (turn_count(array) % 2) == 0 )
    return "X"
  else
    return "O"
  end
end








def won?(array)
  WIN_COMBINATIONS.each do   |element| 
    if ( ( (array[(element[0])] == "X") ) && ( (array[(element[1])]  == "X") ) && ( (array[(element[2])]  == "X") ) )
      return [ element[0], element[1], element[2] ]
    elsif ( ( (array[(element[0])] == "O") ) && ( (array[(element[1])]  == "O") ) && ( (array[(element[2])]  == "O") ) )
      return [ element[0], element[1], element[2] ]
    end
  end
  return false        # I think return false works here.  else return false @ end of the block did not work
end






def full?(array)
  array.none? do |position|  (position == " " || position == "  " || position == "" )
  end
end





def draw?(array)
  if (full?(array) == true) && ( won?(array) == false)    # changed to won? == false, now works
    return true
  else 
    return false
  end
end






def over?(array)
  if won?(array) != false 
    return true
  elsif (draw?(array) == true)    # changed Mar 3 to see if it would make #play test pass
    return true
  # elsif (full?(array) == true) && (won?(array) == false)
  #   return true
  else 
    return false
  end
end 







#return nil if no winner

def winner(array)

  win_x_combo = nil
  win_o_combo = nil
  xs = []
  os = []

    def x_extractor_helper(array, index)  
      array.select.with_index.select do |j, index|     
        j == "X" || j == " X "
      end
    end

    def o_extractor_helper(array, index)  
      array.select.with_index.select do |j, index|      #// or each_with_index
        j == "O" || j == " O "
      end
    end

    def array_dividing_helper_method(array)     # need to go a level deeper in array to access ["a", 1] ?!
      output_array = []
      array.each do  | index0 |
        output_array << index0[1]         # need output_array to be local variable??! 
      end 
      #end            # OLD ending to array_dividing_helper_method
      return output_array
    end             # ends array_dividing_helper_method


  xs = array_dividing_helper_method(x_extractor_helper(array, array))
  os = array_dividing_helper_method(o_extractor_helper(array, array))

  WIN_COMBINATIONS.each do |combo|
      #os.all?          # Instead, try "os contains WIN_COMBINATIONS[i][0] and WIN_COMBINATIONS[i][1] and [i][2] "
    if ( ( xs.include?(combo[0]) ) && ( xs.include?(combo[1]) ) )       # was win_x_combo, not xs
      if  ( xs.include?(combo[2]) )
        #puts "Winning X Combo is  #{combo}    "
        win_x_combo = combo
        #return combo
      else puts "No x Win Combination. current combo is #{combo}"
      end
    end
  end
  
  WIN_COMBINATIONS.each do |combo|
    if ( ( os.include?(combo[0]) ) && ( os.include?(combo[1]) ) )     
     if  ( os.include?(combo[2]) )
       #puts "Winning O Combo is  #{combo}    "
           win_o_combo = combo
           #return combo
         #else puts "No o Win Combination"
     end
    end
  end  


  if ( win_x_combo != nil )
    puts " X Won!"
    return "X"
  end

  if ( win_o_combo != nil )
    puts " O Won!"
    return "O"
  else puts ("No winner") and
    return nil
  end


end   # ends WINNER?







def play(array)
  while(  (over?(array) == false) )      
    turn(array)
  end


  if(draw?(array) == true)
    puts("Cat's Game!")
    return
  end
  if(won?(array) != false)
    puts("Congratulations #{winner(array)}!")    # was winner(board)
    return
  end

end



