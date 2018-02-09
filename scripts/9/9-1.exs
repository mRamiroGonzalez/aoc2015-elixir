
# AOC 2015 9-1

# TODO: find another way to save paths (not in a file)

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
                if(x.to not in acc) do
                    acc ++ [x.to]
                else
                    acc
                end 
             end
        end
     end
     
     def getPathsList(lines) do
        instructions = String.split(lines, "\n")
        Enum.reduce instructions, [], fn (x, acc) ->
            if(x != "") do
                line =  String.replace(x, "\"", "")
                |>  String.replace("[", "")
                |>  String.replace("]", "")
                |>  String.split(", ")
                |>  Enum.reduce([], fn(y, acc2) -> acc2 ++ [y] end)

                acc ++ [line]
            else
                acc
            end
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
            {:ok, file} = File.open("paths.txt",[:append])
            IO.write(file, inspect visited)
            IO.write(file, "\n")
            File.close(file)
        end
    end    
    
end

defmodule CostCalculator do    
    def get_cost(costs, from, to) do
        res = Enum.find costs, fn(x) -> (x.from == from or x.from == to) and (x.to == from or x.to == to) end
        String.to_integer(res.dist)
    end

    def get_cost_for_path(path, costs, acc \\ 0)
    def get_cost_for_path([_], _, acc), do: acc
    def get_cost_for_path([from, to | t], costs, acc) do
        acc = acc + get_cost(costs, from, to)
        get_cost_for_path([to|t], costs, acc)
    end
    
    def get_costs_for_paths(paths, costs, acc \\ 0, results \\ [])
    def get_costs_for_paths([], _, _, results) do
        IO.inspect Enum.min(results)
    end
    def get_costs_for_paths([h|t], costs, acc, results) do
        cost = get_cost_for_path(h, costs)
        results = results ++ [cost]
        get_costs_for_paths(t, costs, acc + 1, results)
    end
end

defmodule Aoc do
    alias InstructionSplitter
    alias PathFinder
    alias CostCalculator

    def parseInput(lines, costs \\ [])
    def parseInput([h|t], costs) do
        instruct = InstructionSplitter.splitInstruction(h)
        parseInput(t, costs ++ [instruct])
    end
    def parseInput([], costs) do
        IO.puts "Getting cities list"
        cities = InstructionSplitter.getCitiesList(costs)
        processInstructions(costs, cities)
    end

    def processInstructions(costs, cities) do
        IO.puts "Getting paths for #{length cities} cities"
        PathFinder.getAllPathsFor(cities)
        IO.puts "Reading path list from file"
        paths = InstructionSplitter.getPathsList(File.read!("paths.txt"))
        IO.puts "Found #{length paths} paths, finding lower cost"
        CostCalculator.get_costs_for_paths(paths, costs)
    end
end

start = :os.system_time(:millisecond)
File.rm("paths.txt")
File.read!("9-input.txt") |> String.split("\n") |> Aoc.parseInput
stop = :os.system_time(:millisecond)
IO.puts "Took #{stop - start} milliseconds"