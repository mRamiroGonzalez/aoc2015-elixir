
defmodule Test do
    def expand(nb) do
        digits = Integer.digits nb
        count(digits)
    end

    def count(start \\ 1)
    def count([n]) do
        IO.puts "Starting with: #{n}"
        count([1] ++ [n])
    end
    def count([h|t]) do
        currentList = [h] ++ t
        IO.puts "List: #{inspect currentList}" 
        newlist = step_and_get_newList(currentList)
        # :timer.sleep(1000)
        count(newlist)
    end

    def step_and_get_newList(list, newList \\ [])
    def step_and_get_newList([], newList), do: newList
    def step_and_get_newList(list, newList) do
        toFind = Enum.at(list, 0)
        nb = nb_of_current(list)
        list = Enum.drop(list, nb)
        newList = newList ++ [nb] ++ [toFind]
        step_and_get_newList(list, newList)
    end

    def nb_of_current(list, nb \\ 1)
    def nb_of_current([_], nb), do: nb
    def nb_of_current([a,b|t], nb) do
        if(a == b) do
            nb_of_current([b] ++ t, nb + 1)
        else
            nb
        end
    end
end

Test.expand(1)