defmodule ApiWeb.ProxyPlug do
    @behaviour Plug
  
    def init(hosts), do: hosts
  
    def call(conn, hosts) do
      path_element = List.first( conn.path_info )
      if Map.has_key?(hosts, path_element) do
          endpoint = Map.fetch!(hosts, path_element)
          conn2 = conn
          |> Map.put( :path_info, List.replace_at( conn.path_info, 0, "api" ) )
          |> Map.put( :request_path, String.replace( conn.request_path, path_element, "api", global: false ) )
          endpoint.call(conn2, endpoint.init(nil))
      else
          endpoint = Map.fetch!(hosts, "default")
          endpoint.call(conn, endpoint.init(nil))
      end

    end
  end