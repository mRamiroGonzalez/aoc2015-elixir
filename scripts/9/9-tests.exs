
defmodule Test do

    def get_all_paths_for(cities) do
        Enum.each cities, fn(x) ->
            Test.path_from(cities, x)
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

cities = ["A","B","C"]
costs = [
    %{city1: "A", city2: "B", cost: 1},
    %{city1: "B", city2: "C", cost: 2},
    %{city1: "A", city2: "C", cost: 4}
]
Test.get_all_paths_for(cities)
IO.inspect Test.get_cost(costs, "A", "C")