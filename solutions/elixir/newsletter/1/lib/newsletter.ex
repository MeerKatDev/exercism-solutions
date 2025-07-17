defmodule Newsletter do
  def read_emails(path) do
    File.read!(path) |> String.split("\n", trim: true)
  end

  def open_log(path) do
    File.open!(path, [:write])
  end

  def log_sent_email(pid, email) do
    IO.puts(pid, email)
  end

  def close_log(pid) do
    File.close(pid)
  end

  def send_newsletter(emails_path, log_path, send_fun) do
    with emails <- read_emails(emails_path),
      log_pid <- open_log(log_path),
      :ok <- Enum.each(emails, fn email ->
          if send_fun.(email) == :ok, 
          do: log_sent_email(log_pid, email)
        end) do
      close_log(log_pid)
    else
      :error -> :error
    end
    
  end
end
