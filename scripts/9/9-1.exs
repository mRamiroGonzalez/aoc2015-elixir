
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
     
     def getPathsList(lines) do
        instructions = String.split(lines, "\n")
        Enum.reduce instructions, [], fn (x, acc) ->
            line =  String.replace(x, "\"", "")
                |>  String.replace("[", "")
                |>  String.replace("]", "")
                |>  String.split(", ")
                |>  Enum.reduce([], fn(y, acc2) -> acc2 ++ [y] end)

            acc ++ [line]
        end
     end
end

defmodule PathFinder do
    def getAllPathsFor(cities) do
        Enum.each cities, fn(x) ->
            pathFrom(cities, x)
        end
    end

    def pathFrom(cities, current, visited \\ []) do
        visited = visited ++ [current]

        Enum.each cities, fn(x) ->
            if (not x in visited) do
                pathFrom(cities, x, visited)                
            end
        end

        if (length(visited) == length(cities)) do
            # IO.inspect visited
            # {:ok, file} = File.open("paths.txt",[:append])
            # IO.write(file, inspect visited)
            # IO.write(file, "\n")
            # File.close(file)
        end
    end    
    
end

defmodule CostCalculator do
    alias InstructionSplitter
    
    def getMinCost(costs) do
        paths = InstructionSplitter.getPathsList(File.read!("paths.txt"))
        IO.inspect paths
        IO.inspect costs
    end

    def getCost(costs, from, to) do
        res = Enum.find costs, fn(x) -> (x.city1 == from or x.city1 == to) and (x.city2 == from or x.city2 == to) end
        res.cost
    end
end

defmodule Aoc do
    alias InstructionSplitter
    alias PathFinder
    alias CostCalculator

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
        PathFinder.getAllPathsFor(cities)
        CostCalculator.getMinCost(tab)
    end
end

File.read!("9-input-test.txt") |> String.split("\n") |> Aoc.parseInput