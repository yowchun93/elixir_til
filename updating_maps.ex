list = TodoList.new
  |> TodoList.add_entry(%{date: {2019, 08, 08}, title: 'Dentist'})
  |> TodoList.add_entry(%{date: {2019, 08, 08}, title: 'Doctor'})

todo_list =
%TodoList{
  auto_id: 3,
  entries: %{
    1 => %{date: {2019, 8, 8}, id: 1, title: 'Dentist'},
    2 => %{date: {2019, 8, 8}, id: 2, title: 'Doctor'}
  }
}

# create a references for entries
entries = todo_list.entries

# To update a value in the entry
{:ok , entry} = Map.fetch(todo_list.entries, 1)
entry = %{date: {2019, 8, 8}, id: 1, title: 'Dentist'}

# Update the found entry
new_entry = Map.put(entry, :title, 'Doctor')

# Construct new copy of entries, with the update new_entry
new_entries = Map.put(entries, new_entry.id, new_entry)

# Return a new TodoList, this is how it works in functional programming.
%TodoList{ todo_list | entries: new_entries }


entry = %{date: {2019, 8, 8}, id: 1, title: 'Dentist'}
update_func = &Map.put(&1, :title, 'Doctor')
update_func = &Map.put(%1, :date, {2019, 8, 8})

# To make the function more composable, allow it to accept function as a lambda,
# Now the function is flexible enough to keys based on the function passed in
def update_entry(todo_list, id, updater_func) do
  case Map.fetch(todo_list.entries, entry_id) do
    :error ->
      todo_list
    {:ok ,old_entry} ->
      new_entry = updater_func.(old_entry)
      new_entries = Map.put(todo_list.entries, new_entry.id, new_entry)
      %TodoList{ todo_list | entris: new_entries }
  end
end
