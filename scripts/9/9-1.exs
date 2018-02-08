
#AOC 2015 9-1

defmodule InstructionSplitter do
    def splitInstruction(line) do
        a = String.split(line, " ")
        %{from: Enum.at(a,0), to: Enum.at(a,2), dist: Enum.at(a,4)}
    end


    def getCitiesList(instuctions, cities \\ []) do
        Enum.reduce instuctions, [], fn (x, acc) ->
             if(x.from not in acc) do
                 acc ++ [x.from]
             else 
                 if(x.to not in cities) do
                     acc ++ [x.to]
                 end 
             end
        end
     end    
end

defmodule PathFinder do
    def get_all_paths_for(cities) do
        Enum.each cities, fn(x) ->
            path_from(cities, x)
        end
    end

    def path_from(cities, current, visited \\ []) do
        visited = visited ++ [current]

        Enum.each cities, fn(x) ->
            if (not x in visited) do
                path_from(cities, x, visited)                
            end
        end

        if (length(visited) == length(cities)) do
            IO.inspect visited    
        end
    end    
    
    def get_cost(costs, from, to) do
        res = Enum.find costs, fn(x) -> (x.city1 == from or x.city1 == to) and (x.city2 == from or x.city2 == to) end
        res.cost
    end

end

defmodule Aoc do
    alias InstructionSplitter
    alias PathFinder

    def parseInput(lines, tab \\ [])
    def parseInput([h|t], tab) do
        instruct = InstructionSplitter.splitInstruction(h)
        parseInput(t, tab ++ [instruct])
    end
    def parseInput([], tab) do
        cities = InstructionSplitter.getCitiesList(tab)
        processInstructions(tab, cities)
    end

    def processInstructions(tab, cities) do
        PathFinder.get_all_paths_for(cities)
    end
end

File.read!("9-input-test.txt") |> String.split("\n") |> Aoc.parseInput