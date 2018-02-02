
# AOC 2015 4-1

defmodule Aoc do    
    def mine(secret, acc) do
        md5 = :crypto.hash(:md5, secret <> Integer.to_string(acc)) |> Base.encode16
        if check(md5) do
            IO.puts "#{acc}: #{md5}"
        else
            mine(secret, acc + 1)
        end
    end

    def check(secret) do
        String.slice(secret,0,5) == "00000" 
    end
end

{:ok, file} = File.read("4-input.txt")
Aoc.mine(file, 0)