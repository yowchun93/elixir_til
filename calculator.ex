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
      {:value, sender } ->
        send(sender, {:response, current_value})
        current_value
      {:add, value} ->
        new_value = current_value + value
        new_value
    end
    loop(new_value)
  end
end
