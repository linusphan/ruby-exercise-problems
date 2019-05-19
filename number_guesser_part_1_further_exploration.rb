class Player
  attr_reader :guess, :tries

  def initialize
    @tries = 7
    @guess = nil
  end

  def guess_number
    loop do
      print "Enter a number between #{GuessingGame::RANGE.first} and #{GuessingGame::RANGE.last}: "
      self.guess = gets.chomp.to_i
      if GuessingGame::RANGE.cover?(guess)
        decrement_tries
        break
      else
        print "Invalid guess. "
      end
    end
  end

  private

  attr_writer :guess, :tries

  def decrement_tries
    self.tries -= 1
  end
end

class GuessingGame
  RANGE = 1..100

  RESULT_OF_GUESS_MESSAGE = {
    high:  "Your number is too high.",
    low:   "Your number is too low.",
    match: "That's the number!"
  }.freeze

  WIN_OR_LOSE = {
    high:  :lose,
    low:   :lose,
    match: :win
  }.freeze

  RESULT_OF_GAME_MESSAGE = {
    win:  "You won!",
    lose: "You have no more guesses. You lost!"
  }.freeze

  def initialize
    @secret_number = nil
    @player = Player.new
  end

  def play
    reset
    game_result = play_game
    display_game_end_message(game_result)
  end

  private

  attr_accessor :secret_number
  attr_reader :player

  def reset
    self.secret_number = rand(RANGE)
  end

  def play_game
    result = nil
    while player.tries > 0
      display_guesses_remaining
      player.guess_number
      result = check_guess
      puts RESULT_OF_GUESS_MESSAGE[result]
      break if result == :match
    end
    WIN_OR_LOSE[result]
  end

  def display_guesses_remaining
    puts
    if player.tries == 1
      puts 'You have 1 guess remaining.'
    else
      puts "You have #{player.tries} guesses remaining."
    end
  end

  def check_guess
    return :match if player.guess == secret_number
    return :low if player.guess < secret_number
    :high
  end

  def display_game_end_message(result)
    puts "", RESULT_OF_GAME_MESSAGE[result]
  end
end

game = GuessingGame.new
game.play
