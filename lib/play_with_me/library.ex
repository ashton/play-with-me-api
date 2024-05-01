defmodule PlayWithMe.Library do
  @moduledoc """
  The GameStore context.
  """

  @doc """
  lists the games of a specific user
  """
  @callback list_games(user_id :: String.t(), opts :: map()) :: Enum.t()
end
