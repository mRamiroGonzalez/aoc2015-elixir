defmodule JsonConverter do

    require Poison

    def parseJson(json) do
        {:ok, parsed} = Poison.Parser.parse json
        IO.inspect parsed
    end

    def start do
        # a = [1, {"c": "red", "b": 2}, 12, [{"aze": 7} , 5], {"e": "red", "f": {"c": 6}}, 3]
        a = ~s([1, {"c": "red", "b": 2}, 12, [{"aze": 7} , 5], {"e": "red", "f": {"c": 6}}, 3])
        JsonConverter.parseJson(a)    
    end
end