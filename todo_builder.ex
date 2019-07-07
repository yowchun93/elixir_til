# This is a TodoList implementation, where the implementations are
# abstracted away.

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

  # TodoList.new |> TodoList.add_entry( %{date: {2013, 12, 19}, title: 'Dentist'}) |> TodoList.add_entry( %{date: {2013, 12, 19}, title: 'Doctor'})
  # entry is a map
  def add_entry(
    %TodoList{entries: entries, auto_id: auto_id} = todo_list,
    entry
  ) do
    entry = Map.put(entry, :id, todo_list.auto_id)
    new_entries = Map.put(todo_list.entries, todo_list.auto_id, entry)

    %TodoList{todo_list |
      entries: new_entries,
      auto_id: todo_list.auto_id + 1
    }
  end

  # wondering why fn {_, entry} , why the first element is ignored
  # |> Stream.filter(fn {_id, entry} -> entry.date == date end)
  # |> Enum.map(fn {_, entry} -> entry end)
  # This is a part i need to look into more.
  def entries(todo_list, date) do
    todo_list.entries
    |> Stream.filter(fn {_id, entry} -> entry.date == date end)
    |> Enum.map(fn {_, entry} -> entry end)
  end

  def update_entry(todo_list, %{} = new_entry) do
    update_entry(todo_list, new_entry.id, fn _ -> new_entry end)
  end

  # TodoList.update_entry(todo_list, 1, &Map.put(&1, :date, {2013, 12, 20}))
  def update_entry(todo_list, id, func) do
    case Map.fetch(todo_list.entries, entry_id) do
      :error ->
        todo_list
      {:ok, old_entry} ->
        new_entry = update_fun.(old_entry)
        new_entries = Map.put(todo_list.entries, new_entry.id, new_entry)
        %TodoList{todo_list | entries: new_entries}
    end
  end

end
