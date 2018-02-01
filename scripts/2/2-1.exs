
# AOC 2015 2-1

defmodule Aoc do
    def parse_input(_, surface \\ 0)
    def parse_input([], surface), do: IO.puts surface
    def parse_input([head | tail], surface) do
        
        dimensions = String.split(head,"x")
        {length, _} = Integer.parse(Enum.at(dimensions,0))
        {width, _} = Integer.parse(Enum.at(dimensions,1))
        {height, _} = Integer.parse(Enum.at(dimensions,2))
        
        surface1 = 2*length*width
        surface2 = 2*width*height
        surface3 = 2*height*length
        surface4 = Integer.floor_div(find_lowest(surface1, surface2, surface3),2)

        increasedSurface = (surface + surface1 + surface2 + surface3 + surface4)
        parse_input(tail, increasedSurface)
    end

    def find_lowest(s1, s2, s3) do
        if(s1 <= s2 && s1 <= s3) do
            s1
        else 
            if(s2 <= s1 && s2 <= s3) do
                s2
            else
                s3
            end
        end
    end
end

{:ok, input} = File.read("2-input.txt")
String.split(input, "\n") |> Aoc.parse_input