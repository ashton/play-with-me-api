defmodule PlayWithMe.GameStoreFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PlayWithMe.GameStore` context.
  """

  @doc """
  Generate a game.
  """
  def game_fixture(attrs \\ %{}) do
    {:ok, game} =
      attrs
      |> Enum.into(%{
        id: "some id",
        name: "some name"
      })
      |> PlayWithMe.GameStore.create_game()

    game
  end
end
