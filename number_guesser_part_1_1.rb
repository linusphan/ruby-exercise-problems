class GuessingGame
  def initialize
    @range = (1..100)
    @answer = @range.to_a.sample
    @tries = 7
  end

  def play
    guess_result = nil
    loop do
      puts answer
      show_tries_left
      guess = make_guess
      guess_result = evaluate_guess(guess)
      decrement_tries unless win?(guess_result)
      show_evaluation_if_high_or_low(guess_result)
      break if tries == 0 || win?(guess_result)
    end
    show_game_result(guess_result)
  end

  protected

  attr_accessor :tries

  private

  attr_reader :range, :answer

  def show_tries_left
    puts "You have #{tries} remaining."
  end

  def decrement_tries
    self.tries -= 1
  end

  def make_guess
    print "Enter a number between #{range.first} and #{range.last}: "
    response = nil
    loop do
      response = gets.chomp
      break if response.to_i.to_s == response && range.cover?(response.to_i)
      print "Invalid guess. "
    end
    response.to_i
  end

  def evaluate_guess(guess)
    if guess == answer   then :win
    elsif tries == 0     then :lose
    elsif guess > answer then :high
    else                      :low
    end
  end

  def show_evaluation_if_high_or_low(result)
    if result == :high
      puts 'Your guess is too high'
    elsif result == :low
      puts 'Your guess is too low'
    end
    puts "" unless result == :win
  end

  def win?(result)
    result == :win
  end

  def show_game_result(guess_result)
    if guess_result == :win
      puts "You win!"
    elsif guess_result == :lose
      puts "You are out of guesses. You lose."
    end
  end
end

GuessingGame.new.play

