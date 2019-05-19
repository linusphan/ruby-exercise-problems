class GuessingGame
  def initialize(range_start_num, range_end_num)
    @range = (range_start_num..range_end_num)
    @tries = Math.log2(@range.size).to_i + 1
    @answer = @range.to_a.sample
  end

  def play
    guess = nil
    loop do
      show_tries
      guess = make_a_guess
      evaluate(guess)
      decrement_tries if !win?(guess)
      break if win?(guess) || show_no_more_tries
    end
    win_or_lose(win?(guess))
  end

  private

  attr_accessor :tries
  attr_reader :answer, :range

  def win?(guess)
    guess == answer
  end

  def win_or_lose(win)
    puts win ? "You win!" : "You lose."
  end

  def show_tries
    puts ""
    puts "You have #{tries} guesses remaining."
  end

  def show_no_more_tries
    return false unless tries == 0
    print 'You are out of guesses. '
    true
  end

  def make_a_guess
    msg = "Enter a number between #{range.first} and #{range.last} (#{answer}): "
    guess = nil
    print msg
    loop do
      guess = gets.chomp
      break if invalid_guess?(guess)
      print "Invalid guess. #{msg}"
    end
    guess.to_i
  end

  def invalid_guess?(guess)
    guess.to_i.to_s == guess && range.cover?(guess.to_i)
  end

  def evaluate(guess)
    return if guess == answer
    if guess > answer
      puts 'Your guess is too high'
    else
      puts 'Your guess is too low'
    end
  end

  def decrement_tries
    @tries -= 1
  end
end

game = GuessingGame.new(501, 1500)
game.play
