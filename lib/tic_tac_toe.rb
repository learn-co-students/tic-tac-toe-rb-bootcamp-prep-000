WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,4,8], [2,4,6], [0,3,6],[1,4,7],[2,5,8]]

def display_board (board)

  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "

end

def input_to_index(user_input)
  user_input.to_i - 1
end

def player_move(board, index, current_player)
  board[index] = current_player
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
  if valid_move?(board, index)
    player_move(board, index,current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count (board)
  count = 0
  board.each do |element|
    if element != " "
      count += 1
    end
  end
  return count
end

def won? (board)

#empty field
empty = board.all? do |field|
  field == " "
end

if empty
  return false
end

#win
WIN_COMBINATIONS.each do |set1|
  if (board[set1[0]] == board[set1[1]] && board[set1[1]]  == board[set1[2]])
    if (board[set1[0]] != " ")
      return set1
    end
  end
end

#draw

if(full?(board) == true)
  return false
end

end




def full? (board)
  emptyfield = board.detect do |field|
    field == " "
  end

  if (emptyfield == nil)
    return true
  else
    return false
  end

end

def draw? (board)

  wina = won? (board)
if !(wina == false)
  return false
end

if(full?(board) == true)
  return true
end
end

def over? (board)
  if draw?(board)
    return true
  end

  if won? (board)
    return true

  else
    return false
  end
end

def winner (board)

  if draw? (board)
    return nil
  end
  if won? (board)

  WIN_COMBINATIONS.each do |set1|
    if (board[set1[0]] == board[set1[1]] && board[set1[1]]  == board[set1[2]])
      if (board[set1[0]] == "X")
        return "X"
      end
      if (board[set1[0]] == "O")
        return "O"
      end
    end
  end
end
end


def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else turn_count(board) % 2 == 1
    "O"
  end
end

  def winning_player (board)
    if !(((turn_count(board)).odd?) == true)
        return "O"
      else
        return "X"
      end
    end


def play (board)

    loop do

      turn(board)

      if(over?(board) == true)
        break
      end

    end

    if !(draw?(board))
      puts "Congratulations #{winning_player(board)}!"
    else
      puts "Cat's Game!"
    end

end
