defmodule Yic.Apis.System do

    alias Yic.Apis.TokenRegistry

    def call( method, url, result ), do: call(method, url, [], result)

    def call( method, url, token, result ) do
        IO.puts "calling #{url} using #{method} with #{token}"

        case TokenRegistry.get( "jwt_local" ) do
            {:ok, token} ->
                headers = [{"Authorization", "Bearer #{token}"}, {"Content-Type", "application/json"}]
                case method do
                    "get" ->
                        case HTTPoison.request( method, url, [], headers, [] ) do
                            {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
                                IO.inspect body
                                bodymap = Poison.decode!(body)

                                {:ok, %{key: result, value: bodymap}}
                            _error ->
                                {:error, %{msg: "failed to get", key: result}}
                        end
                    _method ->
                        IO.puts "Method not yet implemented"
                        {:error, "failed"}
                end
            {:error, msg} ->
                IO.puts "calling #{url} using #{method} with #{token}. Error: #{msg}"
                { result, "some output from calling system by url"}
        end
    end
end