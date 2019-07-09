defmodule TodoServer do
  def start do
    spawn(fn -> loop(TodoList.new) end)
  end

  def loop(todo_list) do
    new_todo_list = receive do
      message ->
        process_message(todo_list, message)
    end
  end
  loop(new_todo_list)
end

defmodule TodoList do
  defstruct auto_id: 1, entries: %{}

  # reduce(enumerable, acc, fun)
  def new(entries \\ []) do
    Enum.reduce(
      entries,
      %TodoList{},
      &add_entry(&2, &1)
    )
  end
end
