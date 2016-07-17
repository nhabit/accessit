defmodule Accessit do

  defmacro access_at(data_structure_string) do
    String.split(data_structure_string, "->")
    |> Enum.map( &get_key_or_index/1 )
    |> Enum.map( &convert_from_capture/1)
  end

  defp get_key_or_index(string) do
    Regex.named_captures(~r/(\{:(?<key>.*)\}|\[(?<index>.*)\])/,string)
  end

  defp convert_from_capture(%{"key" => key, "index" => ""}) do
    String.to_atom(key)
  end

  defp convert_from_capture(%{"key" => "", "index" => index}) do
    index = String.to_integer(index)
    quote do Access.at(unquote(index)) end
  end

end
