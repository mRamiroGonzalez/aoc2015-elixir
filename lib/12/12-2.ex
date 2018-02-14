
defmodule Aoc2015.Twelve.Two do
    
    def getSumOfNumbers(json) do
        list = Poison.Parser.parse! json
        filterValues(list) |> getSum
    end

    def filterValues(parsed) when is_map(parsed) do
        if ("red" in Map.values(parsed)) do
            [0]
        else
            reduceAndFilter(parsed)
        end
    end
    def filterValues(parsed), do: reduceAndFilter(parsed) |> List.flatten

    def reduceAndFilter(json) do
        Enum.reduce json, [], fn(x, acc) ->
            res = 
                cond do
                    is_map(x) or is_list(x) ->
                        filterValues(x)
                    is_tuple(x) ->
                        {_a, b} = x
                        if (is_map(b) or is_list(b)) do
                            filterValues(b)  
                        else
                            b
                        end
                    true ->
                        x
                end
            [res | acc]
        end
    end

    def getSum(list) do
        Enum.reduce(list, 0, fn(x, acc) -> 
            if(is_number(x)) do
                x + acc
            else
                acc
            end
        end)
    end

    def start do
        File.read!("lib/12/12-input.txt") |> getSumOfNumbers |> IO.inspect    
    end
end