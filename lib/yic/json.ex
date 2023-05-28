defmodule Yic.Json do
  require Logger
  use Ecto.Type

  def type(), do: :map

  def dump(map) when is_map(map) or is_list(map), do: {:ok, map}

  def dump(string) when is_binary(string) do
    case Poison.decode(string) do
      {:ok, map} -> 
        {:ok, map}
      {:error, exception} ->
        Logger.error "Invalid JSON when DUMPING to database"
        { :error, "Invalid JSON when DUMPING to database" }
    end
  end
  
  def dump(_), do: { :error, "dump error" }

  def load(map) when is_map(map) or is_list(map) do
    Logger.info "LOADING MAP"
    Poison.encode(map, pretty: true)
  end

  def load(json) when is_binary(json), do: {:ok, json}

  def load(_), do: {:error, "load error"}

  def cast(map) when is_map(map) or is_list(map), do: {:ok, map}

  def cast(json) when is_binary(json) do
    Logger.info "CASTING JSON"
    case Poison.decode(json) do
      {:ok, map} -> 
        {:ok, json}
      {:error, exception} ->
        Logger.error "Invalid JSON when CASTING"
        { :error, message: "Invalid JSON format" }
    end
  end

  def cast(_other), do: {:error, "other error"}
end
