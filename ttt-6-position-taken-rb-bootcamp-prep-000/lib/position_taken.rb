def position_taken?(board, index)
  (board[index] ==  " " || board[index] == "" || board[index] == nil) ?
      false : true
end
