def play(board)
  until over?(board)
    turn(board)
  end
  draw?(board) ? (puts "Cats Game!") : (puts "Congratulations #{winner(board)}!")
end

def turn(board)
  input = get_move
  system('clear')
  index = input_to_index(input)
  while valid_move?(board, index) == false
    display_board(board)
    puts "It is not possible to move to square #{input}"
    input = get_move
    system('clear')
    index = input_to_index(input)
  end
  move(board, index, current_player(board))
  display_board(board)
end

def move(board, index, player)
  !player ? (player = current_player(board)) : nil
  board[index] = player
end

def display_board(cells)
  separator_row = "-----------"
  row1 = " #{cells[0]} | #{cells[1]} | #{cells[2]} "
  row2 = " #{cells[3]} | #{cells[4]} | #{cells[5]} "
  row3 = " #{cells[6]} | #{cells[7]} | #{cells[8]} "
  puts "#{row1}\n#{separator_row}\n#{row2}\n#{separator_row}\n#{row3}"
end

def input_to_index(index)
  index = index.to_i - 1
end

def valid_move?(board, index)
  (position_taken?(board, index) == true || position_on_board?(board, index) == false) ? false : true
end

def position_taken?(board, index)
  (board[index] == "X" || board[index] == "O") ? true : false
end

def position_on_board?(board, index)
  (index >= 0 && index <= 8) ? true : false
end

def get_move
  puts "Please enter 1-9:"
  gets.strip
end

def turn_count(board)
  count = 0
  board.each do |square|
    (square == "O" || square == "X") ? count += 1 : nil
  end
  count
end

def current_player(board)
  turns_played = turn_count(board)
  turns_played.even? == true ? "X" : "O"
  # you could have also used (turns_played % 2 == 0)
  # or even (( (-1)**turns_played + 1 ) / 2) == 0
end

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

def full?(board)
  board.all? {|positions| positions == "X" || positions == "O"}
end

def winner(board)
  x_win = WIN_COMBINATIONS.any? do |combos|
    combos.all? do |positions|
      board[positions] == "X"
    end
  end

  o_win = WIN_COMBINATIONS.any? do |combos|
    combos.all? do |positions|
      board[positions] == "O"
    end
  end

  x_win ? "X" : (o_win ? "O" : nil)
end

def draw?(board)
  won?(board) == nil && full?(board) == true
end


def won?(board)
  winner = winner(board)
  WIN_COMBINATIONS.detect do |combos|
    combos.all? do |positions|
      board[positions] == winner
    end
  end
end

def over?(board)
  draw?(board) == true ||  won?(board) != nil
end
