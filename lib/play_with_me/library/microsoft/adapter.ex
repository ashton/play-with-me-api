defmodule PlayWithMe.Library.Microsoft.Adapter do
  @type game_properties_t :: map()
  @type localized_properties_t :: map()

  alias PlayWithMe.Library.Game

  @doc """
  Transforms the map returned by MicrosoftStore.fetch_game_properties
  to a Game struct
  """
  @spec from_game_properties(game_properties :: [map()]) :: Game.t()
  def from_game_properties(game_properties) do
    %Game{
      id: game_properties |> localized_properties() |> game_name() |> game_id(),
      name: game_properties |> localized_properties() |> game_name()
    }
  end

  @spec localized_properties(game_properties_t()) :: localized_properties_t()
  defp localized_properties(game_properties) do
    game_properties
    |> Map.get("LocalizedProperties")
    |> List.first()
  end

  @spec game_name(localized_properties_t()) :: String.t()
  defp game_name(localized_properties) do
    localized_properties |> Map.get("ProductTitle")
  end

  @spec game_id(String.t()) :: binary()
  defp game_id(game_name) do
    :crypto.hash(:md5, game_name)
  end
end
