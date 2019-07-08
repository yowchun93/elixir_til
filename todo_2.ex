defmodule TodoList do
  defstruct auto_id: 1, entries: %{}

  def new do
    %TodoList{}
  end

  # %{date: {2019, 07, 07}, title: 'Dentist'}
  # list = TodoList.new |> TodoList.add_entry(%{date: {2019, 08, 08}, title: 'Dentist'}) |> TodoList.add_entry(%{date: {2019, 08, 08}, title: 'Doctor'})
  def add_entry(todo_list, entry) do
    entry = Map.put(entry, :id, todo_list.auto_id)
    new_entries = Map.put(todo_list.entries, todo_list.auto_id, entry)

    %TodoList{ todo_list |
      entries: new_entries,
      auto_id: todo_list.auto_id + 1
    }
  end

  def get_entry(todo_list, date) do
    todo_list.entries
    |> Enum.filter(fn {_id, entry} -> entry.date == date end)
  end

  # get TodoList id first
  # update the date in that found entry
  # TodoList.update_entry(todo_list, 1, &Map.put(&1, :date, {2013, 12, 20}))
  # You need to return a new copy of TodoList, when the update is done.
  def update_entry(todo_list, id, title) do
    {:ok , entry} = Map.fetch(todo_list.entries, id)
    new_entry = Map.put(entry, :title, title)
    new_entries = Map.put(todo_list.entries, new_entry.id, new_entry)
    %TodoList{todo_list | entries: new_entries}
  end


  # Thing i tried Map.put(entry, title, title)
  # Another thing i tried Map.put(entry, :title, title)


end
