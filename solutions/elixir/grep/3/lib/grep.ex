defmodule Grep do
  @spec grep(String.t(), [String.t()], [String.t()]) :: String.t()
  def grep(pattern, flags, files) do
    normalize_flags(flags)
    |> insensitive?
    |> process(files, pattern)
    |> postprocess
  end

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
            acc ++ Enum.map(List.delete(lines, ""), &"#{file}:#{&1}")
          end
      end).()
    end)
  end

  defp postprocess(lines) do
    Enum.join(lines, "\n") 
    |> String.trim
    |> (&(&1 == "" && "" || "#{&1}\n")).()
  end

  defp insensitive?(["-i"|flags]), do: { &String.downcase/1, flags }
  defp insensitive?(flags), do: { fn x -> x end, flags }

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

  defp filter(flags) do
    cond do
      ("-x" in flags) and ("-v" in flags) -> &Kernel.!=/2
      "-x" in flags -> &Kernel.==/2
      "-v" in flags -> fn (str, cont) -> not String.contains?(str, cont) end 
      true          -> &String.contains?/2
    end
  end

  defp file_to_strings(file) do
    File.read!(file)
    |> String.split("\n")
  end

  defp normalize_flags(flags) do
    (sublist?(flags, ["-l", "-n"]) && List.delete(flags, "-n") || flags)
    |> Enum.sort
  end

  defp sublist?(big_list, candidate) do
    MapSet.subset?(MapSet.new(candidate), MapSet.new(big_list))
  end
end
