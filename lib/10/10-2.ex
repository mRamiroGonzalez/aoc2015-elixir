
# AOC 2015 10-2

defmodule Aoc2015.Ten.Two do
    def expand(seed, steps) do
        digits = Integer.digits(seed)
        countOneStep(digits, steps)
    end

    def countOneStep(list, steps, acc \\ 0)
    def countOneStep(list, steps, steps), do: IO.puts "Final length: #{length(list)}"
    def countOneStep(list, steps, acc) do
        newlist = processCurrentStep(list)
        countOneStep(newlist, steps, acc + 1)
    end

    def processCurrentStep(list) do
        newList = Enum.reduce list, [], fn(x, acc) ->
            if(Enum.empty?(acc))do
                [x, 1| acc]
            else
                [e, nb| t] = acc
                if(e == x) do
                    [x, nb + 1| t]
                else
                    [x, 1| acc]
                end
            end
        end
        newList |> Enum.reverse
    end

    def start do    
        seed = 1321131112
        start = :os.system_time(:millisecond)

        IO.puts "Starting with: #{seed}"
        expand(seed, 50)

        stop = :os.system_time(:millisecond)
        IO.puts "Took #{(stop - start) / 1000} seconds"     
    end
end