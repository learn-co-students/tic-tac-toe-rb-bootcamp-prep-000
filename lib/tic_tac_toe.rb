TEST_BOARD = ['X', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']

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

CHR_EMPTY = ' '
CHR_SEPAR_H = '-'
CHR_SEPAR_V = '|'
ROWS = 3
COLS = 3
CELLS = ROWS*COLS

def display_board(board)
  row = 1
  col = 1
  puts ''
  board.each_with_index do |cell, index|
    print CHR_EMPTY + cell + CHR_EMPTY
    if col % COLS == 0 
      puts ''
      puts "#{CHR_SEPAR_H * ((COLS*3)+COLS-1)}" if row < ROWS
      row += 1
    else
      print CHR_SEPAR_V
    end
    col += 1
  end
  puts ''
end

def input_to_index(str_input)
  str_input.to_i-1
end

def move(board, index, player)
  board[index] = player
end

def position_taken?(board, position)
  !board[position].strip.empty?
end

def valid_move?(board, position)
  position.between?(0, CELLS-1) && !position_taken?(board, position)
end

def turn(board)
  puts "Enter move (1..9):"
  str_input = gets.strip
  index = input_to_index(str_input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each {|cell| counter += 1 unless cell.strip.empty?}
  counter
end

def current_player(board)
  turn_count(board).even? ? 'X' : 'O'
end

def full?(board)
  turn_count(board) == CELLS
end

# returns nil or the WIN_COMBINATIONS sub-array
def won?(board)
  ret = nil
  WIN_COMBINATIONS.each do |wc|
    if wc.all? {|index| position_taken?(board, index) && board[index] == board[wc[0]]}
      ret = wc
      break
    end
  end
  ret
end

def draw?(board)
  full?(board) && won?(board).nil?
end

def over?(board)
  draw?(board) or won?(board)
end

def winner(board)
  won = won?(board)
  board[won[0]] if won
end

def play(board)
  until over?(board) do
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end