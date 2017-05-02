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
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  num = input.to_i
  num - 1
end



def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  player = current_player(board)
  if valid_move?(board, index)
    move(board, index, player)
    display_board(board)
  else
    turn(board)
  end
end

def won?(board)
  #if (draw?(board))
    #return false
  #end

  WIN_COMBINATIONS.select do |p|
    win_index_1 = p[0]
    win_index_2 = p[1]
    win_index_3 = p[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]


    if ((position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O"))
      return p
    end
  end
  return nil
end

def full?(board)
  WIN_COMBINATIONS.select do |p|
    win_index_1 = p[0]
    win_index_2 = p[1]
    win_index_3 = p[2]

  position_1 = board[win_index_1]
  position_2 = board[win_index_2]
  position_3 = board[win_index_3]


    if (position_1 == " " || position_2 == " " || position_3 == " ")
      return false

    end
  end
  return true
end

def draw?(board)
  w = won?(board)
  f = full?(board)
  if ((w == nil) && (f == true))
      return true
    else return false
    end
end

def over?(board)
  if (draw?(board))

    return true
  elsif(full?(board))
    return true
  end
end

def winner(board)
  if (!draw?(board))
    w = won?(board)
      if (w == nil)
        return nil
      else
      i = w[0]

      return board[i]
      end
    end
end

def turn_count(board)
  count = 0
  board.each do |place|
    if place == "X" || place == "O"
      count += 1
    end
  end
  return count
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def play(board)
  count = 1
  begin
    if (draw?(board))
      puts "Cats Game!"
      break
    end

    if (won?(board))
      win = winner(board)
      puts "Congratulations " + win + "!"
      break
    end

    if (over?(board))
      break
    end

    turn(board)
    count += 1
  end while count <= 10
end

def current_player(board)
turn = turn_count(board)
return turn % 2 == 0 ? "X" : "O"
end
