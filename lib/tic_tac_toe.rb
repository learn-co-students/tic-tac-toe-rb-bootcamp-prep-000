WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def is_number? string
  true if Integer(string) rescue false
end

def input_to_index input
  retval = 0

  if is_number? input
    retval = input.to_i - 1
  else
    retval = -1
  end
end

def move(board, pos, chr)
  board[pos] = chr
end

def valid_move? (board, index)
  index > -1 && index < 8 && !position_taken?(board, index)
end

def position_taken? (board, index)
  reval = nil

  if (board[index] == " ") || (board[index] == "") || (board[index] == nil)
    retval = false
  elsif (board[index] == "X") || (board[index] == "O")
    retval = true
  end
  retval
end

def turn board
  puts "Please enter 1-9:"
  is_valid_move = false
  while is_valid_move == false do
    input = gets.strip
    index = input_to_index(input)
    is_valid_move = valid_move?(board, index)
  end
  piece = board.count{ |x| x == " "} % 2 == 0 ? "O" : "X"
  move(board, index, piece)
  display_board(board)
end

def turn_count board
  count = 0
  board.each do |e|
    if e != " "
      count += 1
    end
  end
  return count
end

def current_player board
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  flag = false
  WIN_COMBINATIONS.map do |x|
    xs = []
    x.each { |y| xs.push(board[y]) }
    flag = !xs.empty? && xs.all? { |x| x == "X" }
    flag = !xs.empty? && xs.all? { |x| x == "O" } if flag == false
    flag = x if flag
    break if flag
  end
  flag
end

def full? board
  board.all? { |x| x == "X" || x =="O" }
end

def draw? board
  full = full?(board)
  won = won?(board)
  full && !won
  #full?(board) && !won?(board)
end

def over? board
  draw?(board) || won?(board)
end

def winner board
  x = won? board
  x.kind_of?(Array) ? board[x[0]] : nil
end

def play board
  play = 0
  while !over? board do

    turn(board)
  end

  if won?(board) != nil
    puts "Congratulations #{winner board}!"
  end

  if draw? board
    puts "Cats Game!"
  end
end
