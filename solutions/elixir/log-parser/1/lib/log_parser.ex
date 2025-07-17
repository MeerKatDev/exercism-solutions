defmodule LogParser do
  def valid_line?(line) do
    Regex.match?(~r/^\[ERROR\]|^\[INFO\]|^\[DEBUG\]|^\[WARNING\]/, line)
  end

  def split_line(line) do
    Regex.split(~r/<[\=\*\+\~\-]*>/, line, trim: false)
  end

  def remove_artifacts(line) do
    Regex.replace(~r/end-of-line\d+/i, line, "")
  end

  def tag_with_user_name(line) do
    case Regex.run(~r/User\s+(\S+)/u, line) do
      [_, username] ->
        "[USER] #{username} " <> line

      _ ->
        line
    end
  end
end
