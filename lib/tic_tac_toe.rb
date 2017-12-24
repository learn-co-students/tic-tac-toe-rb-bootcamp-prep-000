WIN_COMBINATIONS = [
  # win by rows
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    # win by columns
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    # win by diangonal
    [0, 4, 8],
    [6, 4, 2]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(string)
  string.chomp.to_i - 1
end

def move(board, index, token)
  board[index] = token
end

def position_taken?(board, position)
  blanks = ['', ' ', nil]
  !blanks.include?(board[position])
end

def valid_move?(board, index)
  index.between?(0, 8) && !position_taken?(board, index)
end

def turn(board)
  puts "Select 1-9:"
  input = gets.chomp
  index = input_to_index(input)
  if valid_move?(board, index)
    token = current_player(board)
    move(board, index, token)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  board.select { |element| ['X', 'O'].include?(element) }.size
end

def current_player(board)
  turn_count(board).even? ? 'X' : 'O'
end

def won?(board)
  result = nil
  WIN_COMBINATIONS.each do |win_combination|
    count = 0
    first_index = win_combination.first
    # position of the first element of win_combination on board already taken
    if position_taken?(board, first_index)
      token = board[first_index]
      # consolidates number of identical token
      win_combination.each do |index|
        count += 1 if board[index] == token
      end
      result = win_combination if count == 3

     else
      # skip if position not tanken
      next
    end
  end
result
end

def full?(board)
  turn_count(board) == board.size
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  board[won?(board)[0]] if won?(board)
end

def play(board)
  turn(board) until over?(board)

  if won?(board)
    puts "Congratulations, #{winner}"
    exit
  else
    puts "Cat's Game!"
  end
end
