defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """

  @doc """
    Returns a list of strings representing a deck of playing cards
  """

  def create_deck do
    values = ["Ace", "Two", "Three"]
    suits = ["Spades", "Diamonds", "Clubs", "Hearts"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Divides a deck into hand and the remainder of the deck and returns hand.
  ## Example

      iex> deck = Cards.create_deck
      iex> hand = Cards.deal(deck, 2)
      iex> hand
      ["Ace of Spades", "Two of Spades"]

  """

  def deal(deck, hand_size) do
    { hand, _rest_of_cards } = Enum.split(deck, hand_size)
    hand
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      { :ok, binary } -> :erlang.binary_to_term binary
      { :error, _error_message } -> "File does not exist in current path"
    end
  end

  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end