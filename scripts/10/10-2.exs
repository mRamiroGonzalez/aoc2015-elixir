
# AOC 2015 10-2

# 59214

defmodule Aoc do
    def expand(nb) do
        digits = Integer.digits nb
        countOneStep(digits)
    end

    def countOneStep(list, acc \\ 0)
    def countOneStep(list, 50), do: IO.puts "Final length: #{length(list)}"
    def countOneStep(list, acc) do
        start = :os.system_time(:millisecond)

        newlist = processCurrentStep(list)

        stop = :os.system_time(:millisecond)
        IO.puts "Step #{acc + 1} took #{(stop - start) / 1000} seconds"

        countOneStep(newlist, acc + 1)
    end

    def processCurrentStep(list, newList \\ [])
    def processCurrentStep([], newList), do: newList
    def processCurrentStep(list, newList) do
        [toFind | _] = list
        {nb, remainingList} = findNbFirstChar(list)
        newList = newList ++ [nb] ++ [toFind]
        processCurrentStep(remainingList, newList)
    end

    def findNbFirstChar([a, a, a | t]), do: {3, t}
    def findNbFirstChar([a, a | t]), do: {2, t} 
    def findNbFirstChar([_ | t]), do: {1, t}
end

seed = 1321131112
IO.puts "Starting with: #{seed}"
Aoc.expand(seed)