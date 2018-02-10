
# AOC 2015 10-2

# 59214

defmodule Aoc do
    def expand(nb) do
        digits = Integer.digits nb
        countOneStep(digits)
    end

    def countOneStep(list, acc \\ 0)
    def countOneStep(list, 50), do: IO.puts "#{length(list)}"
    def countOneStep([n], acc), do: countOneStep([1] ++ [n], acc + 1)
    def countOneStep([h|t], acc) do
        start = :os.system_time(:millisecond)

        currentList = [h] ++ t
        newlist = processCurrentStep(currentList)

        stop = :os.system_time(:millisecond)
        IO.puts "Step #{acc + 1} took #{(stop - start) / 1000} seconds"

        countOneStep(newlist, acc + 1)
    end

    def processCurrentStep(list, newList \\ [])
    def processCurrentStep([], newList), do: newList
    def processCurrentStep(list, newList) do
        [toFind | _] = list
        nb = findNbFirstChar(list)
        list = Enum.drop(list, nb)
        newList = newList ++ [nb] ++ [toFind]
        processCurrentStep(list, newList)
    end

    def findNbFirstChar([a, a, a | _]), do: 3
    def findNbFirstChar([a, a | _]), do: 2 
    def findNbFirstChar([a | _]), do: 1
end

seed = 1321131112
IO.puts "Starting with: #{seed}"
Aoc.expand(seed)