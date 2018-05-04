defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """

  @doc """
    Returns a list of strings representing a deck
  """
  def create_deck do
    values = ["ace", "two", "three", "four", "five", "six", "seven", "eight", "nine", "jack", "queen", "king"]
    suits = ["spades", "clubs", "hearts", "diamonds"]

    for suit <- suits, value <- values do
      "#{value} #{suit}"
    end
    # Creamos una lista de listas y luego le pasamos el metodo flatten para crear una sola lista
    # lista = for value <- values do
    #           for suit <- suits do
    #             "#{value} #{suit}"
    #           end
    #         end
    # List.flatten(lista)
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Determines whether a deck contains a given card

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "two spades")
      true

  """

  def contains?(deck, card)  do
    Enum.member?(deck, card)
  end

  @doc """
    Divides a deck into a hand and the remainder of the deck.
    The `hand_size` argument indicates how many cards should
    be in the hand.

  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, _deck} = Cards.deal(deck, 1)
      iex> hand
      ["ace spades"]

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)

    File.write(filename, binary)
  end

  def load(filename) do
    # {status, binary} = File.read(filename)
    case File.read(filename) do
       {:ok, binary} -> :erlang.binary_to_term binary
       {:error, _reason} -> "That file does not exist"
    end
  end

  # This is to create withoe pipe operator
  # def create_hand(hand_size) do
  #   deck = Cards.create_deck
  #   deck = Cards.shuffle(deck)
  #   {hand, _deck} = Cards.deal(deck, hand_size)
  #   hand
  # end

  # with pipe operator
  def create_hand(hand_size) do
    Cards.create_deck
      |> Cards.shuffle
        |> Cards.deal(hand_size)

  end
end
