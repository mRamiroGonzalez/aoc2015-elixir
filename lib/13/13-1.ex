
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

        IO.puts "Finding happinesss for each seating"
        findHappinesss(seatingsFromFile, instructions)
    end

    def findHappinesss(seatingsFromFile, instructions) do
        happinesss = Enum.reduce seatingsFromFile, [], fn(seating, acc) ->
            happiness = Enum.reduce seating, 0, fn(person, acc) ->
                index = Enum.find_index(seating, fn(x) -> x == person end)
                person_before = Enum.at(seating, index - 1)
                person_after =
                    if (index == length(seating) - 1) do
                        Enum.at(seating, 0)
                    else
                        Enum.at(seating, index + 1)
                    end

                acc + findHappinessEntry(instructions, person, person_before) + findHappinessEntry(instructions, person, person_after)
            end
            [happiness | acc]
        end
        IO.inspect(Enum.max(happinesss))
    end

    def findHappinessEntry(instructions, person, nextTo) do
        entry =
            Enum.find(instructions, fn (x) ->
                x.person == person and x.nextTo == nextTo
            end)
        entry.points
    end

    def start do
        File.rm("lib/13/paths.txt")
        File.read!("lib/13/13-input.txt") |> String.replace(".", "") |> String.split("\n") |> process
        File.rm("lib/13/paths.txt")
    end
end