class Hand
  include Comparable

  attr_accessor :cards, :bid, :jokers

  def initialize(cards:, bid:)
    @cards = cards.split('')
    @jokers = @cards.find_all { |card| card == JOKER }
    @bid = bid
  end

  def type
    return FIVE_OF_KIND if five_of_kind?
    return FOUR_OF_KIND if four_of_kind?
    return FULL_HOUSE if full_house?
    return THREE_OF_KIND if three_of_kind?
    return TWO_PAIR if two_pair?
    return ONE_PAIR if one_pair?
    HIGH_CARD
  end

  def <=>(other)
    unless type == other.type
      TYPES.index(type) <=> TYPES.index(other.type)
    else
      cards.map { |card| LABELS.index(card)}[0..-1] <=>
      other.cards.map { |card| LABELS.index(card)}[0..-1]
    end
  end

  private

  LABELS = %w(A K Q T 9 8 7 6 5 4 3 2 J)
  JOKER = 'J'

  TYPES = [
    FIVE_OF_KIND = :five_of_kind,
    FOUR_OF_KIND = :four_of_kind,
    FULL_HOUSE = :full_house,
    THREE_OF_KIND = :three_of_kind,
    TWO_PAIR = :two_pair,
    ONE_PAIR = :one_pair,
    HIGH_CARD = :high_card
  ]

  def histogram
    @histogram ||= cards.reject { |card| card.eql?(JOKER) }
                        .group_by { |letter| letter }
                        .map do |letter, grouped|
                          { letter:, instances: grouped.size }
                        end
  end

  def with_same_label(number)
    histogram.find_all { |letter| letter[:instances] == number }
  end

  def with_same_label?(number)
    with_same_label(number).any?
  end

  def jokers?(matches = 1)
    jokers.size == matches
  end

  def five_of_kind?
    with_same_label?(5) ||
      (with_same_label?(4) && jokers?) ||
      (with_same_label?(3) && jokers?(2)) ||
      (with_same_label?(2) && jokers?(3)) ||
      jokers?(4) ||
      jokers?(5)
  end

  def four_of_kind?
    with_same_label?(4) ||
      (with_same_label?(3) && jokers?) ||
      (with_same_label?(2) && jokers?(2)) ||
      jokers?(4) ||
      jokers?(3)
  end

  def full_house?
    (with_same_label?(3) && with_same_label?(2)) ||
      (with_same_label(2).size.eql?(2) && jokers?)
  end

  def three_of_kind?
    with_same_label?(3)|| (with_same_label?(2) && jokers?) || jokers?(2) || jokers?(3)
  end

  def two_pair?
    with_same_label(2).size.eql?(2)
  end

  def one_pair?
    with_same_label?(2) || jokers?
  end
end
