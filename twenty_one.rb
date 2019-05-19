system 'cls'

SUITS = ['Hearts', 'Diamonds', 'Spades', 'Clubs']
FACE_CARDS = ['Jack', 'Queen', 'King']

def prompt(msg)
  puts "=> #{msg}"
end

def initialize_deck
  values = (2..10).to_a
  values = values.map(&:to_s)
  values += FACE_CARDS
  deck = []
  SUITS.each do |suit|
    values.each do |value|
      deck.push([suit, value])
    end
  end
  deck
end

def deal(cards)
  card = cards.sample
  cards.delete(card)
  card
end

def calculate_total(hand)
  total = 0
  hand.each do |card|
    total += card.last.to_i if card.last.to_i != 0
    total += 10 if FACE_CARDS.include?(card.last)
    if card.last == "Ace"
      total += if total + 11 <= 21
                 11
               else
                 1
               end
    end
  end

  total
end

def result(player, dealer)
  case calculate_total(player) <=> calculate_total(dealer)
  when 1 then "Player"
  when 0 then "Draw"
  when -1 then "Dealer"
  end
end

def busted?(total)
  total > 21
end

def join_hand(hand)
  hand = hand.map { |card| card[1] }
  if hand.size > 2
    hand[-1] = "and #{hand.last}"
    hand.join(', ')
  else
    hand.join(" and ")
  end
end

def show_hands(player, dealer, hidden='true')
  if hidden
    puts "Dealer has: #{dealer.first[1]} and unknown card"
  else
    puts "Dealer has: #{join_hand(dealer)}"
  end
  puts "You have: #{join_hand(player)}"
end

# main game loop
loop do
  deck = initialize_deck
  player_hand = []
  dealer_hand = []

  2.times do
    dealer_hand << deal(deck)
    player_hand << deal(deck)
  end

  answer = nil

  # player turn
  loop do
    # system 'cls'
    show_hands(player_hand, dealer_hand)

    puts "hit or stay?"
    answer = gets.chomp.downcase

    if answer == 'hit'
      player_hand << deal(deck)
    end

    break if answer == "stay" || busted?(calculate_total(player_hand))

    if answer != 'hit' && answer != 'stay'
      puts "That is not a valid choice. Please try again."
    end
  end

  if busted?(calculate_total(player_hand))
    show_hands(player_hand, dealer_hand)
    puts "You busted. Dealer wins!"
  else
    puts "You chose to stay!"

    # dealer turn
    loop do
      break if busted?(calculate_total(dealer_hand))
      if calculate_total(dealer_hand) >= 17
        break
      else
        dealer_hand << deal(deck)
      end
    end

    if busted?(calculate_total(dealer_hand))
      show_hands(player_hand, dealer_hand, false)
      puts "Dealer busted. Player wins!"
    else
      show_hands(player_hand, dealer_hand, false)
      if result(player_hand, dealer_hand) == "Draw"
        puts "It's a draw!"
      else
        puts "The winner is... #{result(player_hand, dealer_hand)}!"
      end
    end
  end

  prompt "Do you want to play again? (y or n)"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end
