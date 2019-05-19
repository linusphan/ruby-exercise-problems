=begin
Number Guesser Part 1

input: You pass no argument when creating a new instance of GuessingGame
output: Calling GuessingGame#play starts a new game

rules:
  - range of numbers: 1 to 100
  - limit of 7 guesses per game
  - a game object should start a new game with a new number to guess
    with each call to #play

data structure/type
  - Integers -> keep track of number of guesses
  - Range -> select the target number from the range
  - String -> Lots of text to be displayed

steps:
  - define a GuessingGame class
    - constructor
      - does not need any arguments
      - sets a new target
      - sets the number of guesses remaining
    - define make_a_guess method
      - has it's own validation
      - loops until results
      - for each guess, it makes an evaluation
        - is it too high or too low?
      - show results after make_a_guess finishes executing
=end

class GuessingGame
  def initialize
    @tries = 7
    @range = 1..100
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

game = GuessingGame.new
game.play
