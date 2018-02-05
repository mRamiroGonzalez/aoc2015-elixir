
# AOC 2015 7-1

defmodule Aoc do
    def parseInput([]), do: IO.puts "end"
    def parseInput([h|t]) do
        IO.puts "#{inspect split_instruction(h)}"
        parseInput(t)
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
                        %{i: :number, i1: nb, i2: nil, o: Enum.at(instruct,2)}
                    :error ->
                        %{i: :cable, i1: Enum.at(instruct,1), i2: nil, o: Enum.at(instruct,2)}
                end
            _ ->
                %{i: :not, i1: Enum.at(instruct,0), i2: nil, o: Enum.at(instruct,2)}
            end
    end
end

File.read!("7-input.txt") |> String.split("\n") |> Aoc.parseInput