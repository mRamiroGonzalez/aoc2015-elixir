
# AOC 2015 7-1

defmodule Int16 do
    use Bitwise

    def bNot(nb), do: 65535 - nb
    def bOr(a, b), do: bor(a, b)
    def bAnd(a, b), do: band(a, b)
    def bLshift(a, b), do: round(a * :math.pow(2, b))
    def bRshift(a, b), do: Integer.floor_div(a, round(:math.pow(2, b)))
end

defmodule Aoc2015.Seven.One do
    alias Int16

    def parseInput(lines, mapList \\ [], wanted \\ "a")
    def parseInput([h|t], mapList, _), do: parseInput(t, mapList ++ [split_instruction(h)])
    def parseInput([], mapList, wanted) do
        valueList = findValueOf(mapList, wanted)
        IO.puts "Value of #{wanted} is #{valueList[wanted]}"
    end

    def findValueOf(list, toFind, foundValues \\ %{}) do
        if (Map.has_key?(foundValues, toFind)) do
            foundValues
        else
            elem = Enum.find list, fn (x) -> x[:o] == toFind end
            # IO.puts "Looking for value of #{inspect elem}"
            foundValues = case elem[:i] do
                :or ->
                    foundValues = findValueOf(list, elem[:i1], findValueOf(list, elem[:i2], foundValues))
                    a = foundValues[elem[:i1]]
                    b = foundValues[elem[:i2]]  
                    Map.put(foundValues, elem[:o], Int16.bOr(a, b))
                :and ->
                    case Integer.parse(elem[:i1]) do
                        {nb, _} ->
                            foundValues = findValueOf(list, elem[:i2], foundValues)
                            b = foundValues[elem[:i2]]
                            Map.put(foundValues, elem[:o], Int16.bAnd(nb, b))
                        :error ->
                            foundValues = findValueOf(list, elem[:i1], findValueOf(list, elem[:i2], foundValues))
                            a = foundValues[elem[:i1]]
                            b = foundValues[elem[:i2]]  
                            Map.put(foundValues, elem[:o], Int16.bAnd(a, b))
                    end
                :rshift ->
                    foundValues = findValueOf(list, elem[:i1], foundValues)
                    a = foundValues[elem[:i1]]
                    b = elem[:i2]
                    Map.put(foundValues, elem[:o], Int16.bRshift(a, b))
                :lshift ->
                    foundValues = findValueOf(list, elem[:i1], foundValues)
                    a = foundValues[elem[:i1]]
                    b = elem[:i2]
                    Map.put(foundValues, elem[:o], Int16.bLshift(a, b))
                :number ->
                    Map.put(foundValues, elem[:o], elem[:i1])
                :cable ->
                    foundValues = findValueOf(list, elem[:i1], foundValues)
                    a = foundValues[elem[:i1]]
                    Map.put(foundValues, elem[:o], a)
                :not ->
                    foundValues = findValueOf(list, elem[:i1], foundValues)
                    a = foundValues[elem[:i1]]
                    Map.put(foundValues, elem[:o], Int16.bNot(a))
            end
            # :timer.sleep(500)
            # IO.puts "#{inspect foundValues}"
            foundValues
        end
    end

    def split_instruction(line) do
        instruct = String.split(line, " ")
        case Enum.at(instruct,1) do
            "OR" ->
                %{i: :or, i1: Enum.at(instruct,0), i2: Enum.at(instruct,2), o: Enum.at(instruct,4)}
            "AND" ->
                %{i: :and, i1: Enum.at(instruct,0), i2: Enum.at(instruct,2), o: Enum.at(instruct,4)}
            "RSHIFT" ->
                %{i: :rshift, i1: Enum.at(instruct,0), i2: String.to_integer(Enum.at(instruct,2)), o: Enum.at(instruct,4)}
            "LSHIFT" ->
                %{i: :lshift, i1: Enum.at(instruct,0), i2: String.to_integer(Enum.at(instruct,2)), o: Enum.at(instruct,4)}
            "->" ->
                case Integer.parse(Enum.at(instruct,0)) do
                    {nb, _} ->
                        %{i: :number, i1: nb, o: Enum.at(instruct,2)}
                    :error ->
                        %{i: :cable, i1: Enum.at(instruct,0), o: Enum.at(instruct,2)}
                end
            _ ->
                %{i: :not, i1: Enum.at(instruct,1), o: Enum.at(instruct,3)}
            end
    end

    def pprint(list) do
        Enum.each list, fn (x) -> IO.puts "#{inspect x}" end
    end

    def start do
        File.read!("lib/7/7-input.txt") |> String.split("\n") |> parseInput
        File.read!("lib/7/7-input-2.txt") |> String.split("\n") |> parseInput    
    end
end