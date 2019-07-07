# Basic TodoList support the following features
# 1. Create new data abstraction  2. Adding new entries  3. Querying abstraction

# Make this operation work:  TodoList.new |> TodoList.add_entry( {2013, 12 ,19}, "Dentist")

defmodule TodoList do
  def new(), do: %{}

  def add_entry(todo_list, date, title) do
    # %{todo_list | date: title }
    Map.update(todo_list, date, [title], fn(titles) -> [title | titles] end)
  end

  def entries(todo_list, date) do
    Map.get(todo_list, date)
  end
end
