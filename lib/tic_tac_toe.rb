WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6],
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# code your input_to_index and move method here!
def input_to_index(user_input)
  position = user_input.to_i
  index = position - 1
  return index
end

def move(board, index, char)
  board[index]=char
  return board
end

# code your #position_taken? method here!
def position_taken?(board,index)
  if (board[index]=="X" || board[index]=="O")
    return true
  else
    return false
  end
end


# code your #valid_move? method here
def valid_move?(board, index)
  if  !position_taken?(board,index) && index.between?(0,8)
    true
  else
    false
  end
end

def turn_count(board)
  occupied = 0
  board.each do |space|
    if !(space == "" || space == " ")
      occupied+=1
    end
  end
  return occupied
end

def current_player(board)
  if turn_count(board)%2==0
    return "X"
  else
    return "O"
  end
end

def won?(board)
WIN_COMBINATIONS.each do |wincombo|
  if wincombo.all? do |square|
     board[square] == "X"
   end
     return wincombo
   elsif wincombo.all? do |square|
     board[square] == "O"
   end
     return wincombo
   end
 end
  return false
end



def full?(board)
  WIN_COMBINATIONS.each do |wincombo|
    if wincombo.any? do |square|
      board[square] == ""|| board[square] == " "
            end
      return false
    else
      return true
    end
    end
end

def draw?(board)
  if (!won?(board) && full?(board))
    return true
  else
    return false
  end
end


def over?(board)
  if draw?(board) || won?(board)
    return true
  end
end

def winner(board)
  if won?(board) != false
    return board[won?(board)[0]]
  end
end

def turn(board)
  display_board(board)
  puts "Please enter 1-9:"
  position = gets.strip
  index = input_to_index(position)
end

def play(board)
  turn(board)
  if valid_move(board,index)
    move(board,index,current_player(board))
  elsif position_taken?(board,index)
    puts "That space is taken"
  else
    turn(board)
  end
  if over?(board)!=true
    turn(board)
  elsif draw?(board)
    puts "Cats Game!"
  else
    puts "#{token} wins!"
  end
end
