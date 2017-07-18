
WIN_COMBINATIONS = [  [0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]  ]
board = [" "," "," "," "," "," "," "," "," "]

def display_board(board)
  puts" #{board[0]} | #{board[1]} | #{board[2]} \n-----------\n #{board[3]} | #{board[4]} | #{board[5]} \n-----------\n #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, value)
  board[index] = value
end

def position_taken?(board, index)
  board[index] != " " && board[index] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
     move(board,index,current_player(board))#value="X")
     display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter=0
  board.each do |var| if var=="X" || var=="O"
                         counter=counter+1
                       end
             end
counter=counter
end

def current_player(board)
  if turn_count(board)%2==0
   "X"
  else
   "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |win_combination|
    win_index_1=win_combination[0]
    win_index_2=win_combination[1]
    win_index_3=win_combination[2]

    if board[win_index_1]=="X" && board[win_index_2]=="X" && board[win_index_3]=="X"
       win_combination=win_combination
     elsif board[win_index_1]=="O" && board[win_index_2]=="O" && board[win_index_3]=="O"
       win_combination=win_combination
            else false
     end
                      end
end

def full?(board)
  board.all?{|var| var!=" "}
end

def draw?(board)
  full?(board) && !won?(board)
#   if full?(board) && !won?(board)
#      true
#   elsif full?(board) && won?(board)
#      false
#   elsif !full?(board) && won?(board)
#      false
#   end
end

def over?(board)
  if draw?(board)
    true
  elsif won?(board)
    true
  elsif !full?(board)
    false
  end
end

def winner(board)
  if !won?(board)
     nil
    else
       win_combination=won?(board)

     index1=win_combination[0]
     index2=win_combination[1]
     index3=win_combination[2]
     if board[index1]=="X"&&board[index2]=="X"&&board[index1]=="X"
        "X"
     elsif  board[index1]=="O"&&board[index2]=="O"&&board[index1]=="O"
            "O"
      end
    end
end
############################################################
# winner(board)  over?(board) current_player(board) turn(board)
#"Congratulations X!"
#"Congratulations O!"
#"Cats Game!"

def play(board)
  until over?(board)
         turn(board)
         #value=current_player(board)
  end
  if winner(board)=="X"
    puts "Congratulations X!"
  elsif winner(board)=="O"
    puts "Congratulations O!"
    else
    puts "Cats Game!"
  end
end
