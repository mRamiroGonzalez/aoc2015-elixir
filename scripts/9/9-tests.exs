
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

cities = ["London", "Belfast", "Dublin"]

paths = [
    ["London", "Belfast", "Dublin"],
    ["London", "Dublin", "Belfast"],
    ["Belfast", "London", "Dublin"],
    ["Belfast", "Dublin", "London"],
    ["Dublin", "London", "Belfast"],
    ["Dublin", "Belfast", "London"]
]

costs = [
    %{dist: "464", from: "London", to: "Dublin"},
    %{dist: "518", from: "London", to: "Belfast"},
    %{dist: "141", from: "Dublin", to: "Belfast"}
  ]
Test.get_all_paths_for(cities)
Test.get_costs_for_paths(paths, costs)