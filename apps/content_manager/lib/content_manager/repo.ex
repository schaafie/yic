defmodule ContentManager.Repo do
  use Ecto.Repo, otp_app: :content_manager

  @doc """
  Dynamically loads the repository url from the
  DATABASE_URL environment variable.
  """
  def init(_, opts) do    
    {:ok, opts 
    |> Keyword.put( :url, System.get_env("DATABASE_URL"))
    |> Keyword.put( :username, System.get_env("PGUSER"))
    |> Keyword.put( :password, System.get_env("PGPASSWORD"))
    |> Keyword.put( :hostname, System.get_env("PGHOST"))
    |> Keyword.put( :port, System.get_env("PGPORT") |> String.to_integer) }
  end
end
