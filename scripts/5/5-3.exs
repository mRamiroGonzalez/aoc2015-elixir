
# AOC 2015 5-3 (just for the fun)

IO.puts(
    File.read!("5-input.txt") 
    |> String.split("\n") 
    |> Enum.count fn e -> 
            Regex.match?(~r/([a-zA-Z]{2}).*\1/, e) && Regex.match?(~r/([a-zA-Z]).\1/, e) end)