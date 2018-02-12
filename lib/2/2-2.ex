
# AOC 2015 2-2

defmodule Aoc2015.Two.Two do
    def parse_input(_, ribbon \\ 0)
    def parse_input([], ribbon), do: IO.puts ribbon
    def parse_input([head | tail], ribbon) do
        
        dimensions = String.split(head,"x")
        {length, _} = Integer.parse(Enum.at(dimensions,0))
        {width, _} = Integer.parse(Enum.at(dimensions,1))
        {height, _} = Integer.parse(Enum.at(dimensions,2))
        
        {low1, low2} = find_lowests(length, width, height)
        ribbonLength = low1*2 + low2*2
        spareRibbonLength = length*width*height

        increasedRibbon = ribbon + ribbonLength + spareRibbonLength
        parse_input(tail, increasedRibbon)
    end

    def find_lowest(s1, s2) do
        if(s1 <= s2) do
            s1
        else
            s2
        end
    end

    def find_lowests(s1, s2, s3) do
        if(s1 <= s2 && s1 <= s3) do
            {s1, find_lowest(s2, s3)}
        else 
            if(s2 <= s1 && s2 <= s3) do
                {s2, find_lowest(s1, s3)}
            else
                {s3, find_lowest(s1, s2)}
            end
        end
    end

    def start do
        {:ok, input} = File.read("lib/2/2-input.txt")
        String.split(input, "\n") |> parse_input      
    end
end