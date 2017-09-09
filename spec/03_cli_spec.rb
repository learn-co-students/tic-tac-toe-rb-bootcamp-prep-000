describe "./bin/tictactoe" do
  it 'prints "Welcome to Tic Tac Toe!"' do
    allow($stdout).to receive(:puts)
    allow(self).to receive(:play)

    expect($stdout).to receive(:puts).with("Welcome to Tic Tac Toe!"), "Make sure bin/tictactoe has code that can output 'Welcome to Tic Tac Toe!' exactly."

    run_file("./bin/tictactoe")
  end

  it '`board` is an array with 9 strings with an empty space value, " "' do
    allow($stdout).to receive(:puts)
    allow(self).to receive(:play)

    board = get_variable_from_file("./bin/tictactoe", "board")

    expect(board).to match_array([" "," "," "," "," "," "," "," "," "])
  end

  it 'calls #play passing in the board array' do
    allow($stdout).to receive(:puts)

    expect(self).to receive(:play).with(kind_of(Array))

    run_file("./bin/tictactoe")
  end
end
