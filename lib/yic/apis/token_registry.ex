defmodule Yic.Apis.TokenRegistry do
  use GenServer

  # Client API #
  def start_link( state ) do
    start = GenServer.start_link( __MODULE__, state, name: __MODULE__)

    # This call is only for use in dev and test
    if Mix.env() in [:dev, :test] do
      addsystem
    end

    start
  end

  def addsystem do
    add "jwt_local", %{
      type: "jwt", 
      credentials: %{
        login: "admin", 
        password: "admin", 
        url: "http://localhost:4000/api/sign_in" 
      },
      token: %{ value: "" }
    }
  end

  def add(tokenname, tokendef) do
    # Token args is a map to enable multiple forms of tokens/credentials
    # default token %{ credentials: %{login: "", password: ""}, token: %{ type: "", value:""} }
    GenServer.call( __MODULE__, {:add, tokenname, tokendef} )
  end

  def get( tokenname ) do
    GenServer.call( __MODULE__, {:get, tokenname} )
  end

  # Server API #
  def init(_args) do
    store = :ets.new(:token_store, [:set, :protected, :named_table])
    {:ok, store}
  end

  def handle_call( {:add, tokenname, tokendef}, _from, store) do
    case :ets.insert_new( store, { tokenname, tokendef } ) do
      false -> 
        {:reply, {:error, "system not added to store"}, store}
      true ->
        {:reply, {:ok, "system added"}, store}
    end
  end

  def handle_call( {:get, tokenname}, _from, store) do
    case :ets.lookup(store, tokenname) do
      [] -> 
        {:reply, {:error, "token not found"}, store}
      [{tokenname, token}] ->
        case token.type do
          "jwt" ->
            case token.token.value do
              "" -> 
                case get_jwt_token token.credentials.login, token.credentials.password, token.credentials.url do
                  {:ok, str_token} ->
                    newtoken = %{ type: token.type, credentials: token.credentials, token: %{ value: str_token }}
                    case :ets.insert(store, {tokenname, newtoken}) do
                      true ->
                        {:reply, {:ok, str_token}, store}
                      false ->  
                        {:reply, {:error, "Could not store updated token in token store"}, store}
                      end
                  {:error, msg} ->
                    newtoken = %{ type: token.type, credentials: token.credentials, token: %{ value: false }}
                    case :ets.insert(store, {tokenname, newtoken}) do
                      true ->
                        {:reply, {:error, msg}, store}
                      false ->   
                        {:reply, {:error, msg <>" and could not store updated token in token store"}, store}
                      end
                end
              false ->
                {:reply, {:error, "Token error. Contact admin"}, store}
              str_token ->
                {:reply, {:ok, str_token}, store}
            end
          type -> 
            IO.puts "token type #{type} not implemented"                  
            {:reply, {:error, "type not implemented"}, store}
        end
    end
  end

  defp get_jwt_token login, password, url do
    IO.puts "Finding token"
    body = Poison.encode!( %{ login: login, password: password } )
    headers = [{"Content-type", "application/json"}]
    case HTTPoison.post(url, body, headers, []) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        bodymap = Poison.decode!(body)
        token = bodymap["data"]["token"]
        {:ok, token}
      _error ->
        IO.puts "No Token found and returning"
        {:error, "failed to login"}
    end
  end

  def handle_info(_info, state), do: {:noreply, state}

end
