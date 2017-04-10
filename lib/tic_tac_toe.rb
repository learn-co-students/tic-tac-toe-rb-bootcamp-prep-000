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

def display_board(boardState)
  puts(" #{boardState[0]} | #{boardState[1]} | #{boardState[2]} ")
  puts("-----------")
  puts(" #{boardState[3]} | #{boardState[4]} | #{boardState[5]} ")
  puts("-----------")
  puts(" #{boardState[6]} | #{boardState[7]} | #{boardState[8]} ")
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if draw?(board)
    puts("Cats Game!")
  end
  if won?(board)
    puts("Congratulations #{winner(board)}!")
  end
end


def input_to_index(user_input)
  user_input = (user_input.to_i) -1
end

def move(board,index, player_symbol)
  if valid_move?(board,index)
    board[index]=player_symbol
  else
    puts "Hey! Don't do that!"
    turn(board)
  end
end

def valid_move?(board,index)
  return (index<board.length && index>=0 && !position_taken?(board,index))
end

def position_taken?(board,index)
  return board[index]=="O" || board[index]=="X"
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  player_symbol = current_player(board)
  if valid_move?(board, index)
    move(board, index,player_symbol)
    display_board(board)
  else
    puts("Not a valid move. Try again! :)")
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |position|
    if position=="X" || position=="O"
      count+=1
    end
  end
  return count
end


def current_player(board)
  turn_count(board)%2==0 ? "X" : "O"
end


def won?(board)
  WIN_COMBINATIONS.each do |combinations|
    winning_combo =( combinations.all? do |combo_part|
        board[combo_part] =="X"
      end ||
      combinations.all? do |combo_part|
        board[combo_part]=="O"
      end)
      if winning_combo 
        return combinations
      end
    end
  return false
end

def full?(board)
  board.all? do |square|
    square == "X" || square =="O"
  end
end



def draw?(board)
  won?(board)                #I had to include this useless line to pass test...
  return( full?(board) && !won?(board) )
end

def over?(board)
  return draw?(board) || won?(board) 
end

def winner(board)
  if won?(board)                       #any array is truthy
    return board[won?(board)[0]]       #value in first index of winning combo == winner
  end
  return nil
end



