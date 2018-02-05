
# AOC 2015 7-1

defmodule Int16 do
    use Bitwise

    def bNot(nb), do: 65535 - nb
    def bOr(a, b), do: bor(a, b)
    def bAnd(a, b), do: band(a, b)
    def bLshift(a, b), do: round(a * :math.pow(2, b))
    def bRshift(a, b), do: Integer.floor_div(a, round(:math.pow(2, b)))
end

defmodule ListOps do
    def pprint(list) do
        IO.puts "#{inspect list}"
        Enum.each list, fn (x) -> IO.puts "#{inspect x}" end
    end

    def process(list) do
    end
end

defmodule Aoc do
    alias ListOps

    def parseInput(lines, mapList \\ [])
    def parseInput([h|t], mapList), do: parseInput(t, mapList ++ [split_instruction(h)])
    def parseInput([], mapList) do
        # ListOps.pprint(mapList)
        ListOps.process(mapList)
        IO.puts "stop"
    end

    def split_instruction(line) do
        instruct = String.split(line, " ")
        case Enum.at(instruct,1) do
            "OR" ->
                %{i: :or, i1: Enum.at(instruct,0), i2: Enum.at(instruct,2), o: Enum.at(instruct,4)}
            "AND" ->
                %{i: :and, i1: Enum.at(instruct,0), i2: Enum.at(instruct,2), o: Enum.at(instruct,4)}
            "RSHIFT" ->
                %{i: :rshift, i1: Enum.at(instruct,0), i2: Enum.at(instruct,2), o: Enum.at(instruct,4)}
            "LSHIFT" ->
                %{i: :lshift, i1: Enum.at(instruct,0), i2: Enum.at(instruct,2), o: Enum.at(instruct,4)}
            "->" ->
                case Integer.parse(Enum.at(instruct,0)) do
                    {nb, _} ->
                        %{i: :number, i1: Integer.to_string(nb), o: Enum.at(instruct,2)}
                    :error ->
                        %{i: :cable, i1: Enum.at(instruct,0), o: Enum.at(instruct,2)}
                end
            _ ->
                %{i: :not, i1: Enum.at(instruct,1), o: Enum.at(instruct,3)}
            end
    end
end

File.read!("7-input.txt") |> String.split("\n") |> Aoc.parseInput