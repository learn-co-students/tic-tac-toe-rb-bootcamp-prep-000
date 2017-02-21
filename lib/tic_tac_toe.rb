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

def play(board)
    while over?(board) == false
      display_board(board)
      turn(board)
    end
    if won?(board) == true
      puts "Congratulations #{winner(board)}!"
    elsif draw?(board) == true
      puts "Cats Game!"
    end
end

def turn(board)
  puts "Please enter a number between 1-9:"
  input = input_to_index(gets.strip)
  player = current_player(board)

  if valid_move?(board, input)
    move(board, input, player)
    return board
  else
    puts "That was not a valid entry."
    turn(board)
  end
end


def move(board, index, player)
  puts "move"
  board[index] = player
end

def input_to_index(str)
  return str.to_i-1
end




def current_player(board)
  puts "current_player"
  if (turn_count(board) % 2 == 0)
    return "X"
  else
    return "O"
  end
end

def turn_count(board)
  turns = 0
  board.each do |spot|
    if spot != " "
      turns += 1
    end
  end
  return turns
end

def winner(board)
  puts "winner"
  players = ["X","O"]
  players.each do |player|
    WIN_COMBINATIONS.each do |wincombo|
      if board[wincombo[0]] == player && board[wincombo[1]] == player && board[wincombo[2]] == player
        return player
      end
    end
  end
  return nil
end

def over?(board)
  if draw?(board) == true
    return true
  elsif won?(board) == true
    return true
  else
    return false
  end
end

def draw?(board)
  puts "draw?"
    if won?(board) == true
      return false
    end
    if full?(board) == true
      return true
    end
end

def full?(board)
  puts "full?"
  board.all? {|pos| pos == "X" || pos == "O"}
end


def won?(board)
  players = ["X","O"]
  players.each do |player|
    WIN_COMBINATIONS.each do |wincombo|
      if board[wincombo[0]] == player && board[wincombo[1]] == player && board[wincombo[2]] == player
        return true
      end
    end
  end
  return false
end

def valid_move?(board, index)
  puts "valid move?"
  if (index > -1 && index < 9)
    if (position_taken?(board, index) == false)
      return true
    end
  else
    return false
  end
end

def position_taken?(board, index)
  if board[index] != " "
      return true
  end
  return false
end
