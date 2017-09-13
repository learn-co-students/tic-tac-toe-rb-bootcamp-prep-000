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

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
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

def turn_count(board)
counter = 0
  board.each do |value|
    if value=="X" || value=="O"
      counter+=1
    end
  end
  return counter
end

def current_player(board)
  remainder = turn_count(board)%2
  if remainder == 0
    return "X"
  else
    return"O"
  end
end

def won?(board)
  players = ["X","O"]
  won=false

  WIN_COMBINATIONS.each do |arr|
    if board[arr[0]]=="X" || board[arr[0]]=="O"
      if board[arr[0]]==board[arr[1]] && board[arr[0]]==board[arr[2]]
        won=true
        return arr
      end

    end

  end
return won
end

def full?(board)
  return board.none?{|i| i==" " || i==""}
end

def draw?(board)
  return full?(board)==true && won?(board)==false

end

def over?(board)
  return won?(board)!=false || full?(board)==true

end

def winner(board)
winarr=[]
  if over?(board) && !draw?(board)
    winarr=won?(board)
    return board[winarr[0]]
  else
    return nil
  end
end
