
# NOT MY CODE: https://www.reddit.com/r/adventofcode/comments/3w6h3m/day_10_solutions/cxu3dyt/

defmodule AdventOfCode.DayTen do

    def look_and_say(n, target) do
        look_and_say(n |> Integer.digits, 0, target)
    end
  
    def look_and_say(res, n, n) do
        length(res)
    end
  
    def look_and_say(list, x, n) do
        look_and_say(compress(list), x + 1, n)
    end
  
    defp compress(list) do
        list = Enum.reduce(list, [], fn(e, a) ->
            cond do
                Enum.empty?(a) -> 
                    [{e, 1}|a]
                true ->
                    [head={x, c}|tail] = a
                    comp = compare(head, e)
                    case {comp, head} do
                        {{e, _}, {e, _}} -> 
                            [comp|tail]
                        _ -> 
                            [comp, x ,c|tail]
                    end
            end
        end)
        [{a, b}|tail] = list
        [a, b|tail] |> Enum.reverse
    end
  
    defp compare(head, e) do
        {ex, count} = head
        cond do
            e == ex -> {ex, count + 1}
            true    -> {e, 1}
        end
    end
end

start = :os.system_time(:millisecond)
IO.inspect AdventOfCode.DayTen.look_and_say(1321131112, 50)
stop = :os.system_time(:millisecond)
IO.puts "Took #{(stop - start) / 1000} seconds"