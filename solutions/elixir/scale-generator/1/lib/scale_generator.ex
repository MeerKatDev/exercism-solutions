defmodule ScaleGenerator do


  @chromatic_scale ~w(C C# D D# E F F# G G# A A# B)
  @flat_chromatic_scale ~w(C Db D Eb E F Gb G Ab A Bb B)

  @use_sharps ~w(C G D a A E B F# major e b f# c# g# d#)
  @use_flats ~w(F Bb Eb Ab Db Gb major d g c f bb eb)

  @doc """
  Find the note for a given interval (`step`) in a `scale` after the `tonic`.

  "m": one semitone
  "M": two semitones (full tone)
  "A": augmented second (three semitones)

  Given the `tonic` "D" in the `scale` (C C# D D# E F F# G G# A A# B C), you
  should return the following notes for the given `step`:

  "m": D#
  "M": E
  "A": F
  """
  @spec step(scale :: list(String.t()), tonic :: String.t(), step :: String.t()) ::
          list(String.t())
  def step(scale, tonic, step) do
    tonic_pos = find_tonic_idx(tonic, scale)
    note_pos = tonic_pos + interval(step)
    Enum.at(scale, note_pos*(note_pos > tonic_pos && 1 || -1))
  end

  @doc """
  The chromatic scale is a musical scale with thirteen pitches, each a semitone
  (half-tone) above or below another.

  Notes with a sharp (#) are a semitone higher than the note below them, where
  the next letter note is a full tone except in the case of B and E, which have
  no sharps.

  Generate these notes, starting with the given `tonic` and wrapping back
  around to the note before it, ending with the tonic an octave higher than the
  original. If the `tonic` is lowercase, capitalize it.

  "C" should generate: ~w(C C# D D# E F F# G G# A A# B C)
  """
  @spec chromatic_scale(tonic :: String.t()) :: list(String.t())
  def chromatic_scale(tonic0 \\ "C") do
    tonic = String.capitalize(tonic0)
    {a, b} = Enum.split_while(@chromatic_scale, &(&1 != tonic))
    b ++ a ++ [tonic]
  end

  @doc """
  Sharp notes can also be considered the flat (b) note of the tone above them,
  so the notes can also be represented as:

  A Bb B C Db D Eb E F Gb G Ab

  Generate these notes, starting with the given `tonic` and wrapping back
  around to the note before it, ending with the tonic an octave higher than the
  original. If the `tonic` is lowercase, capitalize it.

  "C" should generate: ~w(C Db D Eb E F Gb G Ab A Bb B C)
  """
  @spec flat_chromatic_scale(tonic :: String.t()) :: list(String.t())
  def flat_chromatic_scale(tonic0 \\ "C") do
    tonic = String.capitalize(tonic0)
    {a, b} = Enum.split_while(@flat_chromatic_scale, &(&1 != tonic))
    b ++ a ++ [tonic]
  end

  @doc """
  Certain scales will require the use of the flat version, depending on the
  `tonic` (key) that begins them, which is C in the above examples.

  For any of the following tonics, use the flat chromatic scale:

  F Bb Eb Ab Db Gb d g c f bb eb

  For all others, use the regular chromatic scale.
  """
  @spec find_chromatic_scale(tonic :: String.t()) :: list(String.t())
  def find_chromatic_scale(tonic = <<_dg::bytes-1>> <> "#"), do: chromatic_scale(tonic)
  def find_chromatic_scale(tonic = <<_dg::bytes-1>> <> "b"), do: flat_chromatic_scale(tonic)
  def find_chromatic_scale(tonic) when tonic in @use_sharps, do: chromatic_scale(tonic)
  def find_chromatic_scale(tonic) when tonic in @use_flats, do: flat_chromatic_scale(tonic)

  @doc """
  The `pattern` string will let you know how many steps to make for the next
  note in the scale.

  For example, a C Major scale will receive the pattern "MMmMMMm", which
  indicates you will start with C, make a full step over C# to D, another over
  D# to E, then a semitone, stepping from E to F (again, E has no sharp). You
  can follow the rest of the pattern to get:

  C D E F G A B C
  """
  @spec scale(tonic :: String.t(), pattern :: String.t()) :: list(String.t())
  def scale(tonic, pattern) do
    scale = find_chromatic_scale(tonic)
    tonic_uc = String.capitalize(tonic)
    String.codepoints(pattern)
    |> Enum.reduce([tonic_uc], fn x, [h | _tl] = acc ->
      [step(scale, h, x) | acc]
    end)
    |> Enum.reverse()
  end

  defp interval("m"), do: 1
  defp interval("M"), do: 2
  defp interval("A"), do: 3

  defp find_tonic_idx(tonic, scale) do
    Enum.find_index(scale, &(tonic == &1))
  end
end
