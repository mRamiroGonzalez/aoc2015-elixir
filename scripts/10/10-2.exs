
# AOC 2015 10-2

defmodule Aoc do
    def expand(nb) do
        digits = Integer.digits(nb)
        countOneStep(digits)
    end

    def countOneStep(list, acc \\ 0)
    def countOneStep(list, 50), do: IO.puts "Final length: #{length(list)}"
    def countOneStep(list, acc) do
        start = :os.system_time(:millisecond)
        newlist = processCurrentStep(list)
        stop = :os.system_time(:millisecond)

        IO.puts "Step #{acc + 1} took #{round((stop - start) / 1000)} seconds"
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

    def findNbFirstChar(list) do
        case list do
            [a,a,a|t] -> {3, t}
            [a,a|t] -> {2, t}
            [_|t] -> {1, t}
        end
    end
end

start = :os.system_time(:millisecond)

seed = 1321131112
IO.puts "Starting with: #{seed}"
Aoc.expand(seed)

stop = :os.system_time(:millisecond)
IO.puts "Took #{(stop - start) / 1000} seconds"