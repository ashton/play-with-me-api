defmodule PlayWithMe.Library.Microsoft.Store do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://storeedgefd.dsx.mp.microsoft.com/v8.0/sdk"
  plug Tesla.Middleware.Query, market: "BR", locale: "pt-br", deviceFamily: "windows.desktop"
  plug Tesla.Middleware.JSON

  def fetch_games_attributes(games) do
    {:ok, response} =
      post("/products", %{"productIds" => Enum.join(games, ",")})

    response.body["Products"]
  end
end
