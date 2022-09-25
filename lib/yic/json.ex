defmodule Yic.Json do
  use Ecto.Type

  def type(), do: :map

  def dump(map) when is_map(map) or is_list(map), do: {:ok, map}

  def dump(string) when is_binary(string) do
    case Poison.decode(string) do
      {:ok, map} -> 
        {:ok, map}
      {:error, exception} ->
        IO.puts "Invalid JSON when DUMPING to database"
        :error
    end
  end
  
  def dump(_), do: :error

  def load(map) when is_map(map) or is_list(map) do
    IO.puts "LOADING MAP"
    Poison.encode(map, pretty: true)
  end

  def load(json) when is_binary(json), do: {:ok, json}

  def load(_), do: :error

  def cast(map) when is_map(map) or is_list(map), do: {:ok, map}

  def cast(json) when is_binary(json) do
    IO.puts "CASTING JSON"
    case Poison.decode(json) do
      {:ok, map} -> 
        {:ok, json}
      {:error, exception} ->
        IO.puts "Invalid JSON when CASTING"
        { :error, message: "Invalid JSON format" }
    end
  end

  def cast(_other), do: :error
end
