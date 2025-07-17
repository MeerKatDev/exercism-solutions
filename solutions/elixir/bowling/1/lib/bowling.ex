defmodule Bowling do
  # prev_frame {roll before previous, previous roll}
  defstruct frame: 0, score: 0, prev_frame: {nil,nil}
  @type game :: struct

  # frames are actually half frames
  @max_frames 20
  @max_pins 10

  defguard pins_wrong?(frame, last, roll) when roll > @max_pins
    or (rem(frame, 2) == 1 and (last + roll > @max_pins) and last < @max_pins)
    or (frame > 19 and last+roll > @max_pins and last < @max_pins and roll != @max_pins)
  defguard is_spare?(fst, snd, frame) when fst + snd == @max_pins and frame < 19 and rem(frame, 2) == 0
  defguard game_over?(fst, snd, frame) when frame > 19 and fst + snd < @max_pins
  defguard cannot_take_score?(fst, snd, frame, score) when ((frame < @max_frames and score == 0)
    or (frame <= @max_frames and fst + snd >= @max_pins)) and score < 300

  @doc """
    Creates a new game of bowling that can be used to store the results of
    the game
  """
  @spec start() :: game
  def start do
    %Bowling{}
  end

  @doc """
    Records the number of pins knocked down on a single roll. Returns `any`
    unless there is something wrong with the given number of pins, in which
    case it returns a helpful message.
  """
  @spec roll(game, integer) :: game | String.t()
  def roll(_, roll) when roll < 0,
  do: {:error, "Negative roll is invalid"}
  def roll(%Bowling{frame: frame, prev_frame: {fst, snd}}, _) when game_over?(fst, snd, frame),
  do: {:error, "Cannot roll after game is over"}
  def roll(%Bowling{frame: 20, prev_frame: {10, snd}}, 10) when snd < 10,
  do: {:error, "Pin count exceeds pins on the lane"}
  def roll(%Bowling{frame: frame, prev_frame: {_, snd}}, roll) when pins_wrong?(frame, snd, roll),
  do: {:error, "Pin count exceeds pins on the lane"}
  def roll(%Bowling{frame: frame, score: score, prev_frame: {fst, snd}}, roll) do
    %Bowling{
      frame: frame + 1,
      score: score + calc_score(frame, fst, snd, roll),
      prev_frame: {snd, roll}
    }
  end

  defp calc_score(frame, 10, snd, roll) when frame < (@max_frames - 1), do: roll * 2 + snd
  defp calc_score(frame, fst, 10, roll) when frame < (@max_frames - 1) and fst < 10, do: roll * 2
  defp calc_score(frame, fst, snd, roll) when is_spare?(fst, snd, frame), do: roll * 2
  defp calc_score(_, _, _, roll), do: roll

  @doc """
    Returns the score of a given game of bowling if the game is complete.
    If the game isn't complete, it returns a helpful message.
  """
  @spec score(game) :: integer | String.t()
  def score(%Bowling{frame: frame, score: score, prev_frame: {fst, snd}}) when cannot_take_score?(fst, snd, frame, score) do
    {:error, "Score cannot be taken until the end of the game"}
  end
  def score(game) do
    min(game.score, 300)
  end
end
