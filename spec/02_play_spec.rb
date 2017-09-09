require_relative '../lib/tic_tac_toe.rb'

describe './lib/tic_tac_toe.rb' do  
  describe '#play' do
    it 'asks for players input on a turn of the game' do
      board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
      allow($stdout).to receive(:puts)
      allow(self).to receive(:over?).and_return(false, true)

      expect(self).to receive(:gets).at_least(:once).and_return("1")

      play(board)
    end

    it 'checks if the game is over after every turn' do
      board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
      allow($stdout).to receive(:puts)
      allow(self).to receive(:gets).and_return("1", "2", "3")

      expect(self).to receive(:over?).at_least(:twice).and_return(false, false, true)

      play(board)
    end

    it 'plays the first turn of the game' do
      board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
      allow($stdout).to receive(:puts)
      allow(self).to receive(:gets).and_return("1")

      allow(self).to receive(:over?).and_return(false, true)

      play(board)
      expect(board).to match_array(["X", " ", " ", " ", " ", " ", " ", " ", " "])
    end

    it 'plays the first few turns of the game' do
      board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
      num_of_turns = 0
      allow($stdout).to receive(:puts)
      allow(self).to receive(:gets).and_return("1","2","3")
      allow(self).to receive(:over?).and_return(false, false, false, true)
      allow(self).to receive(:turn) do
        num_of_turns += 1
        Process.exit!(true) if num_of_turns > 10
      end.and_call_original

      play(board)

      expect(board).to match_array(["X", "O", "X", " ", " ", " ", " ", " ", " "])
    end

    it 'checks if the game is won after every turn' do
      board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
      allow($stdout).to receive(:puts)
      allow(self).to receive(:gets).and_return("1", "2", "3")
      allow(self).to receive(:winner).and_return("X")

      expect(self).to receive(:won?).at_least(:twice).and_return(false, false, true)

      play(board)
    end

    it 'checks if the game is draw after every turn' do
      board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
      allow($stdout).to receive(:puts)
      allow(self).to receive(:gets).and_return("1", "2", "3")

      expect(self).to receive(:draw?).at_least(:twice).and_return(false, false, true)

      play(board)
    end

    it 'stops playing if someone has won' do
      board = ["X", "X", "X", " ", " ", " ", " ", " ", " "]
      allow($stdout).to receive(:puts)

      expect(self).to_not receive(:turn)

      play(board)
    end

    it 'congratulates the winner X' do
      board = ["X", "X", "X", " ", " ", " ", " ", " ", " "]
      allow($stdout).to receive(:puts)

      expect($stdout).to receive(:puts).with("Congratulations X!")

      play(board)
    end

    it 'congratulates the winner O' do
      board = [" ", " ", " ", " ", " ", " ", "O", "O", "O"]
      allow($stdout).to receive(:puts)

      expect($stdout).to receive(:puts).with("Congratulations O!")

      play(board)
    end

    it 'stops playing in a draw' do
      board = ["X", "O", "X", "O", "X", "X", "O", "X", "O"]
      allow($stdout).to receive(:puts)

      expect(self).to_not receive(:turn)

      play(board)
    end

    it 'prints "Cat\'s Game!" on a draw' do
      board = ["X", "O", "X", "O", "X", "X", "O", "X", "O"]
      allow($stdout).to receive(:puts)

      expect($stdout).to receive(:puts).with("Cat's Game!")

      play(board)
    end

    it 'plays through an entire game' do
      board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
      allow($stdout).to receive(:puts)

      expect(self).to receive(:gets).and_return("1")
      expect(self).to receive(:gets).and_return("2")
      expect(self).to receive(:gets).and_return("3")
      expect(self).to receive(:gets).and_return("4")
      expect(self).to receive(:gets).and_return("5")
      expect(self).to receive(:gets).and_return("6")
      expect(self).to receive(:gets).and_return("7")

      expect($stdout).to receive(:puts).with("Congratulations X!")

      play(board)
    end
  end
end
