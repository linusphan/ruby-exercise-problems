VALID_CHOICES = %w(rock paper scissors lizard spock)

WINNING_MOVES = {
  "rock" => ['lizard', 'scissors'],
  "paper" => ['spock', 'rock'],
  "scissors" => ['lizard', 'paper'],
  "lizard" => ['spock', 'paper'],
  "spock" => ['rock', 'scissors']
}

SHORTHAND = {
  "r" => "rock",
  "p" => "paper",
  "sc" => "scissors",
  "l" => "lizard",
  "sp" => "spock"
}

def prompt(message)
  Kernel.puts("=> #{message}")
end

def win?(first, second)
  WINNING_MOVES[first].include?(second)
end

def display_result(player, computer)
  if win?(player, computer)
    prompt("You won!")
  elsif win?(computer, player)
    prompt("Computer won!")
  else
    prompt("It's a tie!")
  end
end

loop do
  prompt("First to reach 5 wins is the grand winner, and the match is over.")

  player_score = 0
  computer_score = 0

  while player_score < 5 && computer_score < 5

    choice = ''
    # loop is for getting user choice and choice validation
    loop do
      prompt("Choose one: #{VALID_CHOICES.join(', ')}")
      prompt("You can use shorthand: 'r' for rock, 'p' for paper, etc.")
      prompt("'sc' for scissors or 'sp' for spock")
      Kernel.puts()

      choice = Kernel.gets().chomp()
      choice = SHORTHAND[choice] if SHORTHAND.include?(choice)

      if VALID_CHOICES.include?(choice)
        break
      else
        prompt("That's not a valid choice.")
      end
    end

    computer_choice = VALID_CHOICES.sample()

    Kernel.puts("You chose: #{choice}; Computer chose: #{computer_choice}")
    display_result(choice, computer_choice)

    # incrementing score
    if win?(choice, computer_choice)
      player_score += 1
    elsif win?(computer_choice, choice)
      computer_score += 1
    end

    Kernel.puts("Your score: #{player_score}; " \
                "Computer score: #{computer_score}")

    # checking for the grand winner
    if player_score == 5
      Kernel.puts("Congratulations! You are the grand winner!")
    elsif computer_score == 5
      Kernel.puts("Computer is the grand winner!")
    end

    # Improve readability when running program.
    Kernel.puts()
  end

  # play again? The purpose for the 'big' loop
  prompt("Do you want to play again? (Y)")
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end

prompt("Thank you for playing. Good bye!")
