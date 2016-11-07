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



def display_board(board = [" ", " ", " ", " ", " ", " ", " ", " ", " "])
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def play(board)
  while !(over?(board)) do
      turn(board)
    end
    if won?(board)
      puts "Congratulations " + winner(board) + "!"
    else
      puts "Cats Game!"
    end
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

def turn_count(board)
  counter = 0
  board.each do |box|
    if box != " "
      counter += 1
    end
  end
  counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def input_to_index(input)
    input.to_i - 1
end

def move(board, index, team)
  board[index] = team
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0, 8) && !position_taken?(board, index)
end


def won?(board)
  xcounter = 0
  ocounter = 0
  WIN_COMBINATIONS.each do |combo|

    combo.each do |el|

      if board[el] == "X"
        xcounter += 1
      end

      if board[el] == "O"
        ocounter += 1
      end

      if ocounter == 3 || xcounter == 3
        return combo
      end

    end
    xcounter = 0
    ocounter = 0

  end
false
end

def full?(board)
  board.none? do |el|
    board[el.to_i - 1] == " "
  end
end

def draw?(board)
  !(won?(board)) && full?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  end
  nil
end
