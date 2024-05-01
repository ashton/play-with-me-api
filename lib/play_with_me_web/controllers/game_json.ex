defmodule PlayWithMeWeb.GameJSON do
  alias PlayWithMe.Library.Game

  def index(%{games: games}) do
    %{data: Stream.map(games, &data/1) |> Enum.to_list()}
  end

  def show(%{game: game}) do
    %{data: data(game)}
  end

  defp data(game = %Game{}) do
    Map.new()
    |> Map.put(:id, game.id |> Base.encode16())
    |> Map.put(:name, game.name)
  end
end
