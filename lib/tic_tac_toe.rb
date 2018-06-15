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

def display_board(board, board_array = [])
  e = 0
  3.times do |i|
  board_array << " #{board[e]} | #{board[e+1]} | #{board[e+2]} "
    if i/2 == 0
      board_array << "-----------\n"
    end
  e += 3  
  end
  board_array.each do |x|
    puts x
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if draw?(board)
    puts "Cat's Game!"
  else
    puts "Congratulations #{winner(board)}!"
  end
end

def turn(board)
  puts 'Please enter 1-9:'
  input = input_to_index gets.strip
  if valid_move? board, input
    move(board, input, current_player(board))
    display_board(board)
  else
    puts "invalid"
    turn(board)
  end
end

def move(board, board_index, character)
  board[board_index] = character
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def turn_count(board)
  count = 0
  board.each do |position|
    if position == 'X' || position == 'O'
      count += 1
    end
  end
  return count
end

def current_player(board)
  turns = turn_count(board)
  turns.even? ? "X" : "O"
end

def winner(board)
  if winner = won?(board)
    board[winner[0]]
  end
end

def valid_move?(board, index)
  if index > board.length || index < 0
    false
  else
    !position_taken?(board, index)
  end
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def won?(board)
  WIN_COMBINATIONS.find do |combo|
    board[combo[0]] == board[combo[1]] &&
    board[combo[1]] == board[combo[2]] &&
    position_taken?(board, combo[0])
  end
end

def full?(board)
  !board.include?(" ")
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  draw?(board) || won?(board)
end