class Card
  attr_reader :rank, :suit
  include Comparable

  VALUES = { 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 }

  # Spades > Hearts > Clubs > Diamonds
  SUITS_VALUES = { 'Spades' => 4, 'Hearts' => 3, 'Clubs' => 2, 'Diamonds' => 1 }

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def value
    VALUES.fetch(@rank, @rank)
  end

  def suit_value
    SUITS_VALUES.fetch(@suit)
  end

  def <=>(other_card)
    case value <=> other_card.value
    when 0
      suit_value <=> other_card.suit_value
    else
      value <=> other_card.value
    end
  end
end

cards = [Card.new(8, 'Diamonds'),
         Card.new(8, 'Clubs'),
         Card.new(8, 'Spades')]
puts cards.min # 8 of Diamonds
puts cards.max # 8 of Spades