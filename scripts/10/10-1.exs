
# AOC 2015 10-1

defmodule Aoc do
    def expand(nb) do
        digits = Integer.digits nb
        count(digits)
    end

    def count(list, acc \\ 0)
    def count(list, 40), do: IO.puts "#{length(list)}"
    def count([n], acc), do: count([1] ++ [n], acc + 1)
    def count([h|t], acc) do
        start = :os.system_time(:millisecond)

        currentList = [h] ++ t
        newlist = step_and_get_newList(currentList)

        stop = :os.system_time(:millisecond)
        IO.puts "Step #{acc + 1} took #{(stop - start) / 1000} seconds"

        count(newlist, acc + 1)
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

seed = 1321131112
IO.puts "Starting with: #{seed}"
Aoc.expand(seed)