defmodule Grep do
  @spec grep(String.t(), [String.t()], [String.t()]) :: String.t()
  def grep(pattern, flags, files) do
    preprocess(files, flags, pattern)
    |> String.trim
    |> (&(&1 == "" && "" || "#{&1}\n")).()
  end

  defp preprocess([file], flags, pattern) do
    search_in_file(Enum.sort(flags), file, pattern)
    |> Enum.join("\n")
  end

  defp preprocess(files, flags, pattern) do
    Enum.reduce(files, [], fn file, acc ->
      res = search_in_file(Enum.sort(flags), file, pattern)
      acc ++ [{file, List.delete(res, "")}]
    end)
    |> attach_file_tag(flags)
    |> List.flatten
    |> Enum.join("\n")
  end

  defp attach_file_tag(x, flags) do
    if "-l" in flags do
      Enum.map(x, &elem(&1, 1))
    else 
      Enum.map(x, fn {f, ls} ->
        Enum.map(ls, &"#{f}:#{&1}")
      end)
    end
  end

  defp search_in_file([], file, pattern) do
    file_to_strings(file)
    |> Enum.filter(&String.contains?(&1, pattern)) 
  end

  defp search_in_file(["-i"], file, pattern) do
    downpattern = String.downcase(pattern)

    file_to_strings(file)
    |> Enum.filter(&String.contains?(String.downcase(&1), downpattern)) 
  end

  defp search_in_file(["-n"], file, pattern) do
    file_to_strings(file)
    |> (&Enum.zip(1..(length(&1)), &1)).()
    |> Enum.reduce([], fn {i, x}, acc -> 
      if String.contains?(x, pattern), do: ["#{i}:#{x}" | acc], else: acc
    end)
    |> Enum.reverse()
  end

  defp search_in_file(["-x"], file, pattern) do
    Enum.filter(file_to_strings(file), & &1 == pattern) 
  end

  defp search_in_file(["-v"], file, pattern) do
    Enum.reject(file_to_strings(file), &String.contains?(&1, pattern)) 
  end

  defp search_in_file(["-v", "-x"], file, pattern) do
    Enum.filter(file_to_strings(file), & &1 != pattern) 
  end

  # -n flag has no meaning with -l flag
  defp search_in_file(["-l", "-n"], file, pattern) do
    search_in_file(["-l"], file, pattern)
  end

  defp search_in_file(["-i", "-n", "-x"], file, pattern) do
    downpattern = String.downcase(pattern)

    file_to_strings(file)
    |> (&Enum.zip(1..(length(&1)), &1)).()
    |> Enum.reduce([], fn {i, x}, acc -> 
      if String.downcase(x) == downpattern do
        acc ++ ["#{i}:#{x}"] 
      else 
        acc
      end
    end)
  end

  defp search_in_file(["-i", "-l", "-n", "-x"], file, pattern) do
    downpattern = String.downcase(pattern)

    file_to_strings(file)
    |> (&Enum.zip(1..(length(&1)), &1)).()
    |> Enum.reduce([], fn {_, line}, acc -> 
      if String.downcase(line) == downpattern do
        acc ++ [file] 
      else 
        acc
      end
    end)
  end

  defp search_in_file(["-l"], file, pattern) do
    file_to_strings(file)
    |> Enum.any?(&String.contains?(&1, pattern)) 
    |> if do
      [file]
    else 
      []
    end
  end

  defp file_to_strings(file) do
    File.read!(file)
    |> String.split("\n")
  end
end
