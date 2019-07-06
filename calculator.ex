# Let's build a calculator
defmodule Calculator do

  def start do
    spawn(fn -> loop(0) end)
  end

  def value(pid) do
    send(pid, {:value, self()})

    receive do
      {:response, value} -> value
    end
  end

  def add(pid, value) do
    send(pid, {:add, value})
  end

  defp loop(current_value) do
    new_value = receive do
      message ->
        process_message(current_value, message)
    end
    loop(new_value)
  end

  defp process_message(current_value, {:value, sender}) do
    send(sender, {:response, current_value})
    current_value
  end

  defp process_message(current_value, {:add, value}) do
    new_value = current_value + value
    new_value
  end

end
