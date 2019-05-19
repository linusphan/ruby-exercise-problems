# The game flow:
# - the user makes a choice
# - the computer makes a choice
# - the winner is displayed
# - ask the user if they want to play again

# can see that these will be used more and more.
VALID_CHOICES = ['rock', 'paper', 'scissors']

# nothing more than format the output
# can anticipate this method
def prompt(message)
  Kernel.puts("=> #{message}")
end

def win?(first, second)
  (first == 'rock' && second == 'scissors') ||
    (first == 'paper' && second == 'rock') ||
    (first == 'scissors' && second == 'paper')
end

# for making things easier to read
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
  choice = ''
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
    # need  to validate user input
    choice = Kernel.gets().chomp()

    if VALID_CHOICES.include?(choice)
      break
    else
      prompt("That's not a valid choice.")
    end
  end

  computer_choice = VALID_CHOICES.sample()

  Kernel.puts("You chose: #{choice}; Computer chose: #{computer_choice}")

  display_result(choice, computer_choice)

  prompt("Do you want to play again? (Y)")
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end

prompt("Thank you for playing. Good bye!")
