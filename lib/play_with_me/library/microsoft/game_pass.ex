defmodule PlayWithMe.Library.Microsoft.GamePass do
  @behaviour PlayWithMe.Library

  alias PlayWithMe.Library.Microsoft.Adapter
  alias PlayWithMe.Library.Microsoft.Store

  use Tesla
  plug Tesla.Middleware.BaseUrl, "https://catalog.gamepass.com"
  plug Tesla.Middleware.Query, market: "BR", languages: "pt-br"
  plug Tesla.Middleware.JSON

  @pc_game_pass_id "fdd9e2a7-0fee-49f6-ad69-4354098401ff"
  @console_game_pass_id "f6f1f99f-9b49-4ccd-b3bf-4d9767a77f5e"
  @ea_play_game_pass_id "b8900d09-a491-44cc-916e-32b5acae621b"

  @impl PlayWithMe.Library
  def list_games(user_id, opts) do
    list_games_by_platform(user_id, opts)
  end

  def list_games_by_platform(user_id, %{platform: :console}) do
    list_all_games(user_id, platform_id: @console_game_pass_id)
  end

  def list_games_by_platform(user_id, %{platform: :pc}) do
    list_all_games(user_id, platform_id: @pc_game_pass_id)
  end

  defp list_all_games(_user_id, platform_id: platform_id) do
    {:ok, response} = get("/sigls/v2", query: [id: platform_id])

    response.body
    |> Stream.drop(1)
    |> Stream.filter(&Map.get(&1, "id"))
    |> Stream.map(&Map.get(&1, "id"))
    |> Stream.chunk_every(20)
    |> Task.async_stream(&Store.fetch_games_attributes/1)
    |> Stream.flat_map(fn {:ok, value} -> value end)
    |> Stream.map(&Adapter.from_game_properties/1)
  end
end
