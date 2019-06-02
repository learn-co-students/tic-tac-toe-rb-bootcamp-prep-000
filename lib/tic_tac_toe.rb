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
  # Given input "1" - "9", convert to num 0 - 8
  position = input.to_i - 1
  return position
end

def position_taken?(board, index)
  if (board[index] === "X" || board[index] === "O")
    return true
  elsif !(board[index].nil? || board[index] == " " || board[index] == "")
    return true
  else
    return false
  end
end

def move(board, index, token)
  # Outputs modified board array with char placed in specified position
  board[index] = token
  return board
end

def valid_move?(board, index)
  if ((index >= 0 && index <= 8) && (!position_taken?(board, index)))
    return true
  else
    if (!(index >= 0 && index <= 8))
      puts "Invalid Move"
    elsif (position_taken?(board, index))
      puts "Position taken. Make a new move"
    end
    return false
  end
end


def turn(board)
  puts "Welcome to Tic Tac Toe!"
  
  puts "Which position would you like to go?"
  puts "Please enter 1-9:"
  
  input = gets.strip
  index = input_to_index(input)
  
  if ( valid_move?(board, index) )
    move(board, index, current_player(board))
    display_board(board)
  else
    puts "invalid"
    puts "Enter a proper position 1 - 9"
    turn(board)
  end
end 


def turn_count(board)
  counter = 0
  board.each { |position|
    if (position == "X" || position == "O")
      counter += 1
    end
  }
  return counter
end


def current_player(board)
  if turn_count(board).even?
    return "X"
  elsif turn_count(board).odd?
    return "O"
  end
end


def won?(board)
  WIN_COMBINATIONS.find { |win_combination|
    win_combination.all? { |win_index|
      board[win_index] == "X"
    } || win_combination.all? { |win_index|
      board[win_index] == "O"
    }
  }
end


def full?(board)
    board.all? { |elem|
        elem == "X" || elem == "O"
    }
end


def draw?(board)
    return true if ( !won?(board) && full?(board) )
end 


def over?(board)
    return true if ( won?(board) || draw?(board) || full?(board) )
end 


def winner(board)
    if won?(board)
        return board[won?(board)[0]]
    end
end 


def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end





