defmodule Grep do

  @typep fun_with_flags :: {(String.t() -> String.t()), [String.t()]}

  @spec grep(String.t(), [String.t()], [String.t()]) :: String.t()
  def grep(pattern, flags, files) do
    normalize_flags(flags)
    |> insensitive?
    |> process(files, pattern)
    |> postprocess
  end

  # after getting all the lines according to the flags, 
  # we need to decide how to output those lines (according to the flags, still)
  @spec process(fun_with_flags, [String.t()], String.t()) :: [String.t()]
  defp process({ff, flags}, [file], pattern) do
    method(file_to_strings(file), file, flags, ff.(pattern), ff)
  end

  defp process({ff, flags}, files, pattern) do
    Enum.reduce(files, [], fn file, acc -> 
      file_to_strings(file)
      |> method(file, flags, ff.(pattern), ff)
      |> (fn 
        [] -> acc
        lines ->
          if "-l" in flags do
            acc ++ [lines]
          else 
            acc ++ Enum.map(lines, &"#{file}:#{&1}")
          end
      end).()
    end)
  end

  @spec postprocess([String.t()]) :: String.t()
  defp postprocess(lines) do
    Enum.join(lines, "\n") 
    |> String.trim
    |> case do
      "" -> ""
      li -> "#{li}\n"
    end
  end

  @spec normalize_flags([String.t()]) :: [String.t()]
  defp normalize_flags(flags) do
    (sublist?(flags, ["-l", "-n"]) && List.delete(flags, "-n") || flags)
    |> Enum.sort
  end

  @spec insensitive?([String.t()]) :: fun_with_flags
  defp insensitive?(["-i"|flags]), do: { &String.downcase/1, flags }
  defp insensitive?(flags), do: { fn x -> x end, flags }

  # decides how to filter depending on the flags
  @spec method([String.t()], String.t(), [String.t()], String.t(), String.t()) :: [String.t()]
  defp method(lines, _, ["-n"| flags], pattern, downcase) do
    Enum.zip(1..(length(lines)), lines)
    |> Enum.reduce([], fn {i, x}, acc -> 
      filter(flags).(downcase.(x), pattern) && ["#{i}:#{x}" | acc] || acc
    end)
    |> Enum.reverse()
  end

  defp method(lines, file, ["-l"| flags], pattern, downcase) do
    Enum.any?(lines, &filter(flags).(downcase.(&1), pattern)) && [file] || []
  end

  defp method(lines, _, flags, pattern, downcase) do
    Enum.filter(lines, &filter(flags).(downcase.(&1), pattern))
  end

  @spec filter([String.t()]) :: (String.t(), String.t() -> boolean())
  defp filter(flags) do
    cond do
      ("-x" in flags) and ("-v" in flags) -> &Kernel.!=/2
      "-x" in flags -> &Kernel.==/2
      "-v" in flags -> fn (str, cont) -> not String.contains?(str, cont) end 
      true          -> &String.contains?/2
    end
  end

  @spec file_to_strings(String.t()) :: [String.t()]
  defp file_to_strings(file) do
    File.read!(file)
    |> String.split("\n", trim: true)
  end

  @spec sublist?([String.t()], String.t()) :: boolean()
  defp sublist?(big_list, candidate) do
    MapSet.subset?(MapSet.new(candidate), MapSet.new(big_list))
  end
end
