defmodule PlayWithMe.GameStoreTest do
  use PlayWithMe.DataCase

  alias PlayWithMe.GameStore

  describe "games" do
    alias PlayWithMe.GameStore.Game

    import PlayWithMe.GameStoreFixtures

    @invalid_attrs %{id: nil, name: nil}

    test "list_games/0 returns all games" do
      game = game_fixture()
      assert GameStore.list_games() == [game]
    end

    test "get_game!/1 returns the game with given id" do
      game = game_fixture()
      assert GameStore.get_game!(game.id) == game
    end

    test "create_game/1 with valid data creates a game" do
      valid_attrs = %{id: "some id", name: "some name"}

      assert {:ok, %Game{} = game} = GameStore.create_game(valid_attrs)
      assert game.id == "some id"
      assert game.name == "some name"
    end

    test "create_game/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = GameStore.create_game(@invalid_attrs)
    end

    test "update_game/2 with valid data updates the game" do
      game = game_fixture()
      update_attrs = %{id: "some updated id", name: "some updated name"}

      assert {:ok, %Game{} = game} = GameStore.update_game(game, update_attrs)
      assert game.id == "some updated id"
      assert game.name == "some updated name"
    end

    test "update_game/2 with invalid data returns error changeset" do
      game = game_fixture()
      assert {:error, %Ecto.Changeset{}} = GameStore.update_game(game, @invalid_attrs)
      assert game == GameStore.get_game!(game.id)
    end

    test "delete_game/1 deletes the game" do
      game = game_fixture()
      assert {:ok, %Game{}} = GameStore.delete_game(game)
      assert_raise Ecto.NoResultsError, fn -> GameStore.get_game!(game.id) end
    end

    test "change_game/1 returns a game changeset" do
      game = game_fixture()
      assert %Ecto.Changeset{} = GameStore.change_game(game)
    end
  end
end
