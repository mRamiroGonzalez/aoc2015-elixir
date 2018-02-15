
# Then, if you seat Alice next to David, Alice would lose 2 happiness units (because David talks so much), 
# but David would gain 46 happiness units (because Alice is such a good listener), for a total change of 44.

# If you continue around the table, you could then seat Bob next to Alice (Bob gains 83, Alice gains 54). 
# Finally, seat Carol, who sits next to Bob (Carol gains 60, Bob loses 7) and David (Carol gains 55, David gains 41). 
# The arrangement looks like this:

#      +41 +46
# +55   David    -2
# Carol       Alice
# +60    Bob    +54
#      -7  +83

# After trying every other seating arrangement in this hypothetical scenario, you find that this one is the most optimal, 
# with a total change in happiness of 330.

defmodule Aoc2015.Thirteen.ThingsWithFiles do
    def getSeatingsListFromFile(lines) do
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

    def parseInstructions(instructionsList) do
        Enum.reduce instructionsList, [], fn(x, acc) -> 
            instruction = String.split(x, " ")
            entry = Map.put(%{}, :person, Enum.at(instruction, 0))
            entry = Map.put(entry, :nextTo, Enum.at(instruction, 10))
            entry =
                if(Enum.at(instruction, 2) == "gain") do
                    num = String.to_integer(Enum.at(instruction, 3))
                    Map.put(entry, :points, num)
                else
                    num = String.to_integer(Enum.at(instruction, 3))
                    Map.put(entry, :points, -num)                    
                end
            [entry | acc]
        end
    end
end

defmodule Aoc2015.Thirteen.BoringListThingFindSeatings do
    def getSeatingListFrom(peopleList, current, visited \\ []) do
        visited = visited ++ [current]

        Enum.each peopleList, fn(x) ->
            if (not x in visited) do
                getSeatingListFrom(peopleList, x, visited)                
            end
        end

        if (length(visited) == length(peopleList)) do
            {:ok, file} = File.open("lib/13/paths.txt", [:append])
            IO.write(file, inspect visited)
            IO.write(file, "\n")
            File.close(file)
        end

    end   

    def getSeatingList(peopleList) do
        Enum.each peopleList, fn(x) ->
            getSeatingListFrom(peopleList, x)
        end
     end

    def getPeopleList(instructionsMap) do
        Enum.reduce instructionsMap, [], fn(x, acc) ->
            if(x.person in acc) do
                acc
            else
                [x.person | acc]
            end
        end
    end    
end

defmodule Aoc2015.Thirteen.One do

    def process(list) do
        IO.puts "Parsing instructions"
        instructions = Aoc2015.Thirteen.ThingsWithFiles.parseInstructions(list)
        IO.puts "Getting people list"
        peopleList = Aoc2015.Thirteen.BoringListThingFindSeatings.getPeopleList(instructions)
        IO.puts "Getting seating orders"
        Aoc2015.Thirteen.BoringListThingFindSeatings.getSeatingList(peopleList)
        IO.puts "Recovering seatings from file"
        seatingsFromFile = Aoc2015.Thirteen.ThingsWithFiles.getSeatingsListFromFile(File.read!("lib/13/paths.txt"))
        IO.inspect seatingsFromFile
    end 

    def start do
        File.rm("lib/13/paths.txt")
        File.read!("lib/13/13-input-test.txt") |> String.replace(".", "") |> String.split("\n") |> process    
        File.rm("lib/13/paths.txt")
    end
end