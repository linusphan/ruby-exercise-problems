GAME_NAME = 'Twenty-One'
GAME_TARGET = 21
DEALER_TARGET = 17

SUITS = ['H', 'D', 'S', 'C']
VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

def prompt(msg)
  puts "=> #{msg}"
end

def initialize_deck
  SUITS.product(VALUES).shuffle
end

def total(cards)
  # cards = [['H', '3'], ['S', 'Q'], ... ]
  values = cards.map { |card| card[1] }

  sum = 0
  values.each do |value|
    if value == "A"
      sum += 11
    elsif value.to_i == 0 # J, Q, K
      sum += 10
    else
      sum += value.to_i
    end
  end

  # correct for Aces
  values.select { |value| value == "A" }.count.times do
    sum -= 10 if sum > GAME_TARGET
  end

  sum
end

def busted?(total)
  total > GAME_TARGET
end

# :tie, :dealer, :player, :dealer_busted, :player_busted
def detect_result(dealer_total, player_total)
  if player_total > GAME_TARGET
    :player_busted
  elsif dealer_total > GAME_TARGET
    :dealer_busted
  elsif dealer_total < player_total
    :player
  elsif dealer_total > player_total
    :dealer
  else
    :tie
  end
end

def update_score(dealer_total, player_total, score)
  result = detect_result(dealer_total, player_total)

  case result
  when :player_busted
    score[:dealer] += 1
  when :dealer_busted
    score[:player] += 1
  when :player
    score[:player] += 1
  when :dealer
    score[:dealer] += 1
  end
end

def display_result(dealer_total, player_total)
  result = detect_result(dealer_total, player_total)

  case result
  when :player_busted
    prompt "You busted! Dealer wins!"
  when :dealer_busted
    prompt "Dealer busted! You win!"
  when :player
    prompt "You win!"
  when :dealer
    prompt "Dealer wins!"
  when :tie
    prompt "It's a tie!"
  end
end

def end_of_round_output(dealer_cards, dealer_total, player_cards, player_total)
  puts "=============="
  prompt "Dealer has #{dealer_cards}, for a total of: #{dealer_total}"
  prompt "Player has #{player_cards}, for a total of: #{player_total}"
  puts "=============="
end

def grand_winner?(score)
  if score[:player] >= 5
    puts "**********************"
    puts "Player is the grand winner!"
    puts "**********************"
  elsif score[:dealer] >= 5
    puts "**********************"
    puts "Dealer is the grand winner!"
    puts "**********************"
  end
end

def reset_scores(score)
  score.each { |k, v| score[k] = 0 }
end

def play_again?
  puts "-------------"
  prompt "Do you want to play again? (y or n)"
  answer = gets.chomp
  answer.downcase.start_with?('y')
end

score = { player: 0, dealer: 0 }
loop do
  prompt "Welcome to #{GAME_NAME}!"
  prompt "First to 5 wins."

  # initialize vars
  deck = initialize_deck
  player_cards = []
  dealer_cards = []

  # initial_deal
  2.times do
    player_cards << deck.pop
    dealer_cards << deck.pop
  end

  # initial total
  player_total = total(player_cards)
  dealer_total = total(dealer_cards)

  prompt "Dealer has #{dealer_cards[0]} and ?"
  prompt "You have #{player_cards[0]} and #{player_cards[1]}, for a total of #{player_total}."

  # player turn
  loop do
    player_turn = nil
    loop do
      prompt "Would you like to (h)it or (s)tay?"
      player_turn = gets.chomp.downcase
      break if ['h', 's'].include?(player_turn)
      prompt "Sorry, must enter 'h' or 's'."
    end

    if player_turn == 'h'
      player_cards << deck.pop
      player_total = total(player_cards)
      prompt "You chose to hit!"
      prompt "Your cards are now: #{player_cards}"
      prompt "Your total is now: #{player_total}"
    end

    break if player_turn == 's' || busted?(player_total)
  end

  if busted?(player_total)
    display_result(dealer_total, player_total)
    update_score(dealer_total, player_total, score)
    end_of_round_output(dealer_cards, dealer_total, player_cards, player_total)
    grand_winner?(score)
    reset_scores(score) if score.values.any? { |score| score >= 5 }
    play_again? ? next : break
  else
    prompt "You stayed at #{player_total}"
  end

  # dealer turn
  prompt "Dealer turn..."

  loop do
    break if dealer_total >= DEALER_TARGET

    prompt "Dealer hits!"
    dealer_cards << deck.pop
    dealer_total = total(dealer_cards)
    prompt "Dealer's cards are now: #{dealer_cards}"
  end

  if busted?(dealer_total)
    prompt "Dealer total is now: #{dealer_total}"
    display_result(dealer_total, player_total)
    update_score(dealer_total, player_total, score)
    end_of_round_output(dealer_cards, dealer_total, player_cards, player_total)
    grand_winner?(score)
    reset_scores(score) if score.values.any? { |score| score >= 5 }
    play_again? ? next : break
  else
    prompt "Dealer stays at #{dealer_total}"
  end

  # both player and dealer stays - compare cards!
  end_of_round_output(dealer_cards, dealer_total, player_cards, player_total)
  update_score(dealer_total, player_total, score)
  display_result(dealer_total, player_total)
  grand_winner?(score)
  reset_scores(score) if score.values.any? { |score| score >= 5 }
  break unless play_again?
end

prompt "Thank you for playing #{GAME_NAME}! Good bye!"
