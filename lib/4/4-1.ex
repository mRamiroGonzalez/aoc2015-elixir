
# AOC 2015 4-1

defmodule Aoc2015.Four.One do    
    def mine(secret, acc) do
        md5 = :crypto.hash(:md5, secret <> Integer.to_string(acc)) |> Base.encode16
        if check(md5) do
            IO.puts "#{acc}: #{md5}"
        else
            mine(secret, acc + 1)
        end
    end

    def check(md5) do
        String.slice(md5,0,5) == "00000" 
    end

    def start do
        {:ok, file} = File.read("lib/4/4-input.txt")
        mine(file, 0)     
    end
end