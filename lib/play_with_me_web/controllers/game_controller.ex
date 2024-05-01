defmodule PlayWithMeWeb.GameController do
  use PlayWithMeWeb, :controller
  alias PlayWithMe.Library.Microsoft.GamePass

  def index(conn, _params) do
    result =
      GamePass.list_games(nil, %{platform: :pc})

    conn
    |> put_status(:ok)
    |> render(:index, games: result)
  end
end
