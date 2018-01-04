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
  row0 = board[0..2].join(" | ")
  row1 = board[3..5].join(" | ")
  row2 = board[6..8].join(" | ")
  
  puts " " + row0 + " "
  puts "-----------"
  puts " " + row1 + " "
  puts "-----------"
  puts " " + row2 + " "
end 

def input_to_index(input)
  input.to_i - 1 
end

def move(board, index, player)
  board[index] = player
end 
  
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  (0..8).include?(index) && !position_taken?(board, index)
end 

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)

  until valid_move?(board, index) == true 
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
  end
  
  player = current_player(board)
  move(board, index, player)
end

def current_player(board)
  num = turn_count(board)
  num.even? ? "X" : "O"
end 

def turn_count(board)
  marks = ["X", "O"]
  board.select {|spot| marks.include?(spot)}.count
end
  
def won?(board)
  exs = []
  os = []
  
  board.each_with_index do |spot, i|
    if spot == "X"
      exs << i
    elsif spot == "O"
      os << i
    end 
  end 
  
  result = []
  
  WIN_COMBINATIONS.each do |combo|
    if exs.length >= 3 && combo.all? {|num| exs.include?(num)}
      result << combo
    elsif os.length >=3 && combo.all? {|num| os.include?(num)}
      result << combo
    end  
  end 
  
  !result.empty? ? result[0] : false 
end 

def full?(board)
  board_counts = what_we_have(board)
  
  return true if !board_counts.keys.include?(" ")
  false 
end 

def draw?(board)
  b_counts = what_we_have(board)
  
  if won?(board) != false 
    return false 
  elsif full?(board) || (b_counts["X"] == 4 && b_counts["O"] == 5) || (b_counts["X"] == 5 && b_counts["O"] == 4)
    return true
  end
  false 
end 

def over?(board)
  return true if won?(board) != false || draw?(board) != false 
  false 
end 

def winner(board)
  return nil if won?(board) == false 
  winner_combo = won?(board)
  
  board[winner_combo[0]]

end 

def what_we_have(board)
  counter = Hash.new(0)
  
  board.each do |elem|
    counter[elem] += 1 
  end 
  
  counter 
end 

def play(board)
  
  until over?(board) || won?(board)
    break if won?(board) != false 
    turn(board)
  end 
  
  if won?(board) != false
    current_winner = winner(board)
    puts "Congratulations #{current_winner}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end 
end 

