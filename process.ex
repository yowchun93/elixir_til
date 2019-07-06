@doc """
 Elixir's processes can be compared to objects in Object Oriented Programming.
 BEAM processes are completedly isolated, so an exception happening somewhere in the system
 would not bring the current running process down.
"""

@doc """
1.1 Spawning Processes

spawn(fn -> IO.puts(run_query.("query 1")) end)

A Lambda
async_query = fn(query_def) ->
  spawn(fn -> run_query.(query_def)) end)
end

https://gist.github.com/yowchun93/70b2be47c7cfce45ac2b51fdd02a7057
"""

@doc """
1.2 Message Passing

Processes communicate with each other using message passing.

  Two primitive function which are used for message passing,

  send(pid, {:message, 1}) and
  receive do
    {:message, number} -> number
  end

  https://gist.github.com/yowchun93/3a63c4a0fd11b919b75a1ad0c878d987
"""
